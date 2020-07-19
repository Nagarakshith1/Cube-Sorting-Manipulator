#!/usr/bin/env python
'''
ArUco ROS package for aruco detection.
rvec and tvec (returned by aruco.estimatePoseSingleMarkers) are respectively the rotational and translational vector of ArUco markers

'''
import roslib
import rospy
import sys
import cv2
import cv2.aruco as aruco
import numpy as np

from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image
from sensor_msgs.msg import CameraInfo
from std_msgs.msg import Float32MultiArray
from aruco_ros_opencv.msg import aruco_info_msg

diff_thresh = [0, 0]	# threshlod value to consider new pose only if change in it is greater than threshold
targetSeq = [1,2,3]		# The marker ids to be tracked
goal_dict = {1:[-0.99,-0.104,0,200,-0.01,0.99,0,-100,0,0,-1,111.22]\
,2:[-0.99,-0.104,0,100,-0.01,0.99,0,-150,0,0,-1,111.22]\
,3:[-0.99,-0.104,0,150,-0.01,0.99,0,-100,0,0,-1,111.22]}

visible_arucos = len(targetSeq)	# sets total number of arucos need to be viewed before start publishing
bridge = CvBridge()
distortion_matrix = np.zeros((1,5),np.float64)
camera_matrix = np.zeros((3,3),np.float64)

class Aruco_detection():
	def __init__(self):
		
		rospy.init_node('aruco_detection',anonymous=True)
		self.rate = rospy.Rate(10)
		self.image_pub = rospy.Publisher("/aruco/marked_image_out",Image,queue_size=1)
		self.pose_pub = rospy.Publisher("/aruco/aruco_info_out",aruco_info_msg,queue_size=1)
		self.start_tf_pub = rospy.Publisher("/start_tf",Float32MultiArray,queue_size=1)
		self.goal_tf_pub = rospy.Publisher("/goal_tf",Float32MultiArray,queue_size=1)
		self.start_angle_pub = rospy.Publisher("/start_angle",Float32MultiArray,queue_size=1)

		self.cam_info = rospy.Subscriber("/usb_cam/camera_info",CameraInfo,self.set_camera_parameters)


		rospy.Subscriber("/usb_cam/image_rect_color",Image,self.mark_aruco)
		self.msg = aruco_info_msg()
		
		# dictionary to store information(i.e. x, y, z, angle) of all detected arucos 
		self.aruco_info_dict = {}
		self.all_detected = False

		# Setting format for publishing data
		self.msg.x_position = [0] * visible_arucos	
		self.msg.y_position = [0] * visible_arucos
		self.msg.z_position = [0] * visible_arucos
		self.msg.angle      = [0] * visible_arucos
		self.msg.aruco_id   = [0] * visible_arucos
		self.msg.tf = [0] * (visible_arucos*12)
		self.start_tf_val = Float32MultiArray()
		self.goal_tf_val = Float32MultiArray()
		self.start_angle = Float32MultiArray()
		self.msg.visible_aruco = visible_arucos

	def set_camera_parameters(self, data):
		global distortion_matrix,camera_matrix
		list1 = list(data.K[0:3])
		list2 = list(data.K[3:6])
		list3 = list(data.K[6:9])

		camera_matrix = np.array([list1,list2,list3])
		distortion_matrix = np.array([list(data.D)])

		
	def get_aruco_info(self, corners):
		center_x = 0
		center_y = 0

		rvec, tvec, _ = aruco.estimatePoseSingleMarkers([corners], 0.17, camera_matrix, distortion_matrix)
		center_z = tvec[0][0][2]
		for point in range(len(corners[0])):
			center_x = center_x + corners[0][point][0]
			center_y = center_y + corners[0][point][1]
			if(point == 1):
				line_x = int(center_x/2)
				line_y = int(center_y/2)
		center_x = int(center_x/4)
		center_y = int(center_y/4)
		angle = int(np.rad2deg(np.arctan2(line_y - center_y,line_x - center_x)))
		if angle > 359:
			angle = int(angle - 360)

		return center_x, center_y, center_z, angle


	def detect_all_arucos(self, corners, ids):
		for i in ids:
			id = i[0]
			if id not in self.aruco_info_dict:
				x, y, z, angle  = self.get_aruco_info(corners[ids.tolist().index(i)])
				x = (x - 729)*0.6 #Scaling factors obtained from the camera calibration
				y = (y - 435)*0.5
				angle = angle*np.pi/180

				# Limiting the angle between 0 and pi/2
				if(angle>np.pi/2):
					angle = angle-np.pi/2
				elif(angle<-np.pi/2):
					angle = angle+np.pi
				elif(angle>=-np.pi/2 and angle<-0):
					angle = angle+np.pi/2

				# The transformation matrices 
				tf_cam_arm = np.array([[0,-1,0,203],[-1,0,0,0],[0,0,-1,-18.78],[0,0,0,1]])
				tf_ar_cam = np.array([[np.cos(angle),-np.sin(angle),0,x],[np.sin(angle),np.cos(angle),0,y],[0,0,1,-130],[0,0,0,1]])
				tf = np.matmul(tf_cam_arm,tf_ar_cam).flatten()
				tf = tf[0:12]
				self.aruco_info_dict[id] = [x, y, z, angle,tf]
				
		self.all_detected = True
		if len(self.aruco_info_dict) == visible_arucos:
			for aruco in self.aruco_info_dict.keys():
				if aruco not in targetSeq:
					self.all_detected = False
					rospy.logwarn('Arucos of required ids are not present')
					break
		elif len(self.aruco_info_dict) > visible_arucos:
			self.all_detected = False
			rospy.logwarn('More than specified arucos detected! Try increasing visible_arucos\'s value')

		else:
			self.all_detected = False
			rospy.logwarn('All Arucos not visible.	Try decreasing visible_arucos\'s value')


	def update_their_position(self, corners, ids):
		for i in ids:
			id = i[0]
			if id in self.aruco_info_dict:
				x, y, z, angle  = self.get_aruco_info(corners[ids.tolist().index(i)])
				x = (x - 729)*0.6
				y = (y - 435)*0.5
				angle = angle*np.pi/180

				if(angle>np.pi/2):
					angle = angle-np.pi/2
				elif(angle<-np.pi/2):
					angle = angle+np.pi
				elif(angle>=-np.pi/2 and angle<-0):
					angle = angle+np.pi/2


				if abs(x - self.aruco_info_dict[id][0]) > diff_thresh[0] :
					self.aruco_info_dict[id][0] = x		
				if abs(y - self.aruco_info_dict[id][1]) > diff_thresh[0] :
					self.aruco_info_dict[id][1] = y
				if abs(z - self.aruco_info_dict[id][2]) > diff_thresh[0] :
					self.aruco_info_dict[id][2] = z
					
				if abs(angle - self.aruco_info_dict[id][3]) > diff_thresh[1] :
					self.aruco_info_dict[id][3] = angle		

				tf_cam_arm = np.array([[0,-1,0,203],[-1,0,0,0],[0,0,-1,-18.78],[0,0,0,1]])
				tf_ar_cam = np.array([[np.cos(angle),-np.sin(angle),0,x],\
					[np.sin(angle),np.cos(angle),0,y],[0,0,1,-130],[0,0,0,1]])
				tf = np.matmul(tf_cam_arm,tf_ar_cam).flatten()
				tf = tf[0:12]
				self.aruco_info_dict[id][4] = tf



	
	def mark_aruco(self, data):
		global bridge,distortion_matrix,camera_matrix
		frame = bridge.imgmsg_to_cv2(data,"bgr8")
		gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
		aruco_dict = aruco.Dictionary_get(aruco.DICT_6X6_250)
		parameters = aruco.DetectorParameters_create()

		#lists of ids and the corners beloning to each id
		corners, ids, rejectedImgPoints = aruco.detectMarkers(gray, aruco_dict, parameters=parameters)
		
		
		font = cv2.FONT_HERSHEY_SIMPLEX #font for displaying text (below)
		if np.all(ids != None):
		
			if not self.all_detected:
				self.detect_all_arucos(corners, ids)
			else:
				a = 1
				# self.update_their_position(corners, ids)

			aruco.drawDetectedMarkers(frame, corners) #Draw A square around the markers
			###### DRAW ID #####
			strg = ''
			for i in range(0, ids.size):
				strg += str(ids[i][0])+', '
			cv2.putText(frame, "Id: " + strg, (0,64), font, 1, (0,255,0),2,cv2.LINE_AA)
		else:
			##### DRAW "NO IDS" #####
			cv2.putText(frame, "No Ids", (0,64), font, 1, (0,255,0),2,cv2.LINE_AA)


		if self.all_detected :
			for num, id in enumerate(targetSeq):
				
				self.msg.x_position[num] = self.aruco_info_dict[id][0]
				self.msg.y_position[num] = self.aruco_info_dict[id][1]
				self.msg.z_position[num] = self.aruco_info_dict[id][2]
				self.msg.angle[num]      = self.aruco_info_dict[id][3]
				self.msg.tf[num*12:(num*12)+12] = self.aruco_info_dict[id][4]
				self.msg.aruco_id[num]   = int(id)
				self.goal_tf_val.data[num*12:(num*12)+12] = goal_dict[id]
			print(self.msg)
			self.pose_pub.publish(self.msg)
			
			self.start_tf_val.data = self.msg.tf
			self.start_tf_pub.publish(self.start_tf_val)


			self.goal_tf_pub.publish(self.goal_tf_val)			
			
			self.start_angle.data = self.msg.angle
			self.start_angle_pub.publish(self.start_angle)


		self.image_pub.publish(bridge.cv2_to_imgmsg(frame,"bgr8"))

if __name__=="__main__":
	aruco_det = Aruco_detection()
	while not rospy.is_shutdown():
		aruco_det.rate.sleep()


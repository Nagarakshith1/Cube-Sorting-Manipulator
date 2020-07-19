# Cube Sorting Manipulator
Refer the report for the full description of the project.

[![Watch the video](https://img.youtube.com/vi/0IE7Sr5MsA4/maxresdefault.jpg)](https://youtu.be/0IE7Sr5MsA4)

# Usage 
Camera Calibration

The camera parameters is obtained using the camera_calibration ROS package.
Refer to "http://wiki.ros.org/camera_calibration/Tutorials/MonocularCalibration"

To calibrate:
1) Modify the video device, image width and image height values in usb_cam-test.launch file of usb_cam-develop package.
2) In a terminal execute:
	$ roslaunch usb_cam usb_cam-test.launch 
3) In another terminal:
	$ ROS_NAMESPACE=usb_cam rosrun image_proc image_proc
4) Follow the tutorials and calibrate and save the values. This file will be stored in  tmp folder.
5) Copy paste the contents of the generated yaml file into .ros/camera_info/head_camera.yaml (.ros is a hidden folder can be found by ctrl+H in the home directory)

To obtain the camera pixels of Aruco id run, $ rosrun aruco_ros_opencv aruco_cal.py 

Running the system.
1) Make sure the systems running roscore in Ubuntu (System 1) and the system running MATLAB (System 2) are connected to the same Wifi network
(mobile Hotspot is preferred)

System 1:
Each command is in a different terminal
1) Run $ roscore
2) Run $ roslaunch usb_cam usb_cam-test.launch 
3) Run $ ROS_NAMESPACE=usb_cam rosrun image_proc image_proc
4) In a new terminal get the ip address of you system:
	a) $ hostname -I
	b) $ export ROS_IP=192.168.43.182 (Replace with the IP obtained from the above line)
	c) $ export ROS_MASTER_URI=http://192.168.43.182:11311 (Again just replace the IP before :11311)
	d) $ rosrun aruco_ros_opencv aruco.py 
5) Run $ rosrun lynx_control pathSender
6) Run $ rosrun lynx_control lynxDriver.py (hold the Lynx in Zero position before doing this)

System 2:
1) Open ROS_Node.m and change the argument of the rosinit (on line 12) to the IP address obtained from System 1 (4b)
2) Run ROS_Node.m (Do this between steps 4 and 5 of running System 1)

#!/usr/bin/env python
import rospy
import math
import time
from lynx_control.msg import Lynx
import serial
ser = serial.Serial('/dev/ttyUSB0',115200)
servoOffsets=[1500,1600,1620,1500,2450,2000]
servoDirection = [-1,-1,1,-1,1,1]
servoScales=[2800,2000,2000,1000,2300,2000]
maxOmegas = [0.5,0.5,0.5,2,3,3]
maxSpeedCommands= [636.62*i for i in maxOmegas]
q = [0,0,0,0,0,0]



def callback(data):
    
    
    
    q = data.states
    #Format as in the LynxSevo.m file
    P1 = servoDirection[0]*q[0]/math.pi*servoScales[0]+servoOffsets[0]
    P2 = servoDirection[1]*q[1]/math.pi*servoScales[1]+servoOffsets[1]
    P3 = servoDirection[2]*q[2]/math.pi*servoScales[2]+servoOffsets[2]
    P4 = servoDirection[3]*q[3]/math.pi*servoScales[3]+servoOffsets[3]
    P5 = servoDirection[4]*q[4]/math.pi*servoScales[4]+servoOffsets[4]
    P6 = servoDirection[5]*q[5]/math.pi*servoScales[5]+servoOffsets[5]

    string = "#1P"+str(int(round(P1,0)))+"#2P"+str(int(round(P2,0)))+ "#3P"+str(int(round(P3,0)))+"#4P"+str(int(round(P4,0)))+"#5P"+str(int(round(P5,0)))+"#6P"+str(int(round(P6,0)))

    print('%s \r' %(string))
    ser.write('%s \r' %(string))

def listener():
    rospy.init_node('lynxDriver', anonymous=True)
    rospy.Subscriber("joint_variables", Lynx, callback)
    rospy.spin()

if __name__ == '__main__':
    ser.close()
    ser.open()
    while(ser.in_waiting<=0):
        ser.write(str("INIT").encode())
        time.sleep(1)
        
    listener()
#include <iostream>
#include "ros/ros.h"
#include "std_msgs/Float32MultiArray.h"
#include "lynx_control/Lynx.h"

class Path_sender
{
private:
	ros::NodeHandle n_;
	ros::Subscriber path_sub_;
	ros::Publisher joint_pub_;
	double begin_;
	double end_;
	lynx_control::Lynx joint;
public:

	Path_sender()
	{
		path_sub_ = n_.subscribe("path",1,&Path_sender::path_sender_callback,this);
		joint_pub_ = n_.advertise<lynx_control::Lynx>("joint_variables",1);
	}

	void path_sender_callback(const std_msgs::Float32MultiArray& path)
	{
		// The first value sent in the path is the number of points in the trajectory
		int size = path.data[0];
		for(int i=0;i<size;i++)
		{	
			
			for(int j = (6*i+1),k=0 ;j<(6*i+1)+7,k<6;j++,k++)
			{
				joint.states[k] = path.data[j];
			}
			begin_ = ros::Time::now().toSec();
			end_ = ros::Time::now().toSec();
			while(end_-begin_< 1)
			{
				joint_pub_.publish(joint);
				ros::Duration(3).sleep();
				end_ = ros::Time::now().toSec();
				
			}
		}
	}
};


int main(int argc,char **argv)
{
	ros::init(argc,argv,"pathSender");
	Path_sender path;
	while(ros::ok())
	{
		ros::spin();	
	}
	
	return 0;
}
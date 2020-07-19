function [isCollided] = isRobotCollided(q, map, robot, prism1_pt1, prism1_pt2, prism2_pt1, prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2)
% ISROBOTCOLLIDED Detect if a configuration of the Lynx is in collision
%   with any obstacles on the map.
%
% INPUTS:
%   q   - a 1x6 configuration of the robot
%   map - a map strucutre containing axis-aligned-boundary-box obstacles
%   robot - a structure containing the robot dimensions and joint limits
%
% OUTPUTS:
%   isCollided - a boolean flag: 1 if the robot is in collision, 0 if not.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  Algortihm Starts Here             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isCollided =0;

%defining DH Paramters
a_1 = 0;
alpha_1 = -pi/2;
d_1 = robot.d1;

A_0_1 = dh_single_tf_mat(a_1, alpha_1, d_1, q(1));


a_2 = robot.a2;
alpha_2 = 0;
d_2 = 0;

A_1_2 = dh_single_tf_mat(a_2, alpha_2, d_2, q(2) -  pi / 2);


a_3 = robot.a3;
alpha_3 = 0;
d_3 = 0;

A_2_3 = dh_single_tf_mat(a_3, alpha_3, d_3, q(3) + pi / 2);

a_4 = 0;
alpha_4 = -pi / 2;
d_4 = 0;

A_3_4 = dh_single_tf_mat(a_4, alpha_4, d_4, 0 - pi / 2);

a_5 = 0;
alpha_5 = 0;
d_5 = robot.d5;

A_4_5 = dh_single_tf_mat(a_5, alpha_5, d_5, 0);

A_0_2 = A_0_1 * A_1_2;
A_0_3 = A_0_1 * A_1_2 * A_2_3;
A_0_4 = A_0_1 * A_1_2 * A_2_3 * A_3_4;
A_4_to_joint = [1 0 0 0;
    0 1 0 0;
    0 0 1 robot.d4;
    0 0 0 1;];

A_0_4 = A_0_4 * A_4_to_joint;

A_0_5 = A_0_1 * A_1_2 * A_2_3 * A_3_4 * A_4_5;

% considering the offsets
A_5_to_gripper = [1 0 0 0;
    0 1 0 0;
    0 0 1 robot.lg;
    0 0 0 1;];


A_0_5 = A_0_5 * A_5_to_gripper; %considering the offsets

jointPositions = [     0         0           0    ;
    A_0_1(1,4) A_0_1(2,4) A_0_1(3,4);
    A_0_2(1,4) A_0_2(2,4) A_0_2(3,4);
    A_0_3(1,4) A_0_3(2,4) A_0_3(3,4);
    A_0_4(1,4) A_0_4(2,4) A_0_4(3,4);
    A_0_5(1,4) A_0_5(2,4) A_0_5(3,4);];

%converting discretized lines to frame_0 coordinates
[robot_global_pt1, robot_global_pt2] = local_to_global(A_0_1, A_0_2, A_0_3, A_0_5,...
    prism1_pt1, prism1_pt2, prism2_pt1,prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2);

%checking collision with obstacles
collision = zeros(size(robot_global_pt1,1),1);


for i=1:1:size(map.obstacles,1)
    collision = detectCollision(robot_global_pt1,robot_global_pt2,map.obstacles(i,:));
    isCollided=sum(collision);
    if(isCollided>0)
        
        isCollided=1;
        return
    end
end

prism1 = [-49,0,-49,49,robot.d1+304.8,49];%[xmin,ymin,zmin,xmzx,ymzx,zmax]
prism2 = [-robot.a2,-18,-49,0,18,49];

%checking self-collision with non-adjacent links
a=isRobotSelfCollided(prism1, prism3_pt1, prism3_pt2, A_1_2*A_2_3);
if(a==1)
    isCollided=1;
    return
end

a=isRobotSelfCollided(prism1, prism4_pt1, prism4_pt2, A_1_2*A_2_3*A_3_4*A_4_5);
if(a==1)
    isCollided=1;
    return
end

a=isRobotSelfCollided(prism2, prism4_pt1, prism4_pt2, A_2_3*A_3_4*A_4_5);
if(a==1)
    isCollided=1;
    return
end


%function to calculte the transformation matrix
    function dh = dh_single_tf_mat(a, alpha, d, theta)
        s_theta = sin(theta);
        c_theta = cos(theta);
        s_alpha = sin(alpha);
        c_alpha = cos(alpha);
        
        dh = [c_theta   -s_theta*c_alpha    s_theta*s_alpha    a*c_theta;
            s_theta    c_theta*c_alpha   -c_theta*s_alpha    a*s_theta;
            0           s_alpha                c_alpha         d    ;
            0               0                     0            1    ;];
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  Algortihm Ends Here               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
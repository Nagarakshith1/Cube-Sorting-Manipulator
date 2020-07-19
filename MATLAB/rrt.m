function [path] = rrt(map, start, goal)
% RRT Find the shortest path from start to goal.
%   PATH = rrt(map, start, goal) returns an mx6 matrix, where each row
%   consists of the configuration of the Lynx at a point on the path. The
%   first row is start and the last row is goal. If no path is found, PATH
%   is a 0x6 matrix.
%
% INPUTS:
%   map     - the map object to plan in
%   start   - 1x6 vector of the starting configuration
%   goal:   - 1x6 vector of the goal configuration


%% Prep Code

path = [];
nq=10;          % number of discretizations between two configurations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  Algortihm Starts Here             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('robot.mat');

t_goal = [goal];
t_start = [start];

%parent arrays to track the child
t_goal_parent= [1];
t_start_parent=[1];

%discretizing the robot into lines
%The robot is modeled as a series of four prisms expressed in the local
%frames of the individual joints
prism1 = [-49,0,-49,49,robot.d1+304.8,49];%[xmin,ymin,zmin,xmzx,ymzx,zmax]
prism2 = [-robot.a2,-18,-49,0,18,49];
prism3 = [-robot.a3,-15,-28.5,0,15,28.5];
prism4 = [-15,-34,-(robot.d4+robot.d5+robot.lg),15,34,0];

%generating the start and end points of the lines of the discretized robot
[prism1_pt1, prism1_pt2]=linesgen(prism1);
[prism2_pt1, prism2_pt2]=linesgen(prism2);
[prism3_pt1, prism3_pt2]=linesgen(prism3);
[prism4_pt1, prism4_pt2]=linesgen(prism4);

start_col_check = isRobotCollided(start, map, robot, prism1_pt1, prism1_pt2, prism2_pt1,...
    prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2);
goal_col_check = isRobotCollided(goal, map, robot, prism1_pt1, prism1_pt2, prism2_pt1,...
    prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2);

%checking if start and goal configuration are in obstacle spaces
if(start_col_check>0)
    error("start configuration is in collision sapce");
    path=[];
    return
elseif(goal_col_check>0)
    error("goal configuration is in collision sapce");
    path=[];
    return
end

%checking for violation in joint limits
if(start(1)>robot.upperLim(1)||start(1)<robot.lowerLim(1))
    error('joint 1 out of limits');
    path=[];
    return
elseif(start(2)>robot.upperLim(2)||start(2)<robot.lowerLim(2))
    error('joint 2 out of limits');
    path=[];
    return
elseif(start(3)>robot.upperLim(3)||start(3)<robot.lowerLim(3))
    error('joint 3 out of limits');
    path=[];
    return
elseif(start(4)>robot.upperLim(4)||start(4)<robot.lowerLim(4))
    error('joint 4 out of limits');
    path=[];
    return
end

%random sampling in a loop
for count=1:1:1000
    
    %planning for first four joints
    q1 = randgen(robot.lowerLim(1),robot.upperLim(1));
    q2 = randgen(robot.lowerLim(2),robot.upperLim(2));
    q3 = randgen(robot.lowerLim(3),robot.upperLim(3));
    q4 = randgen(robot.lowerLim(4),robot.upperLim(4));
    q5=0;
    q6=0;
    
    q = [q1, q2, q3, q4, q5, q6];
    
    if(~isRobotCollided(q, map, robot, prism1_pt1, prism1_pt2, prism2_pt1, prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2))
        min_distance=10000;                 % initialising to a large number
        j=0;
        for i=1:1:size(t_start,1)
            distance=pdist([q; t_start(i,1:6)], 'Euclidean');
            if(distance<min_distance)
                min_distance=distance;
                j=i;
            end
        end
        
        %discretizing between two configurations
        d1=linspace(q1,t_start(j,1),nq);
        d2=linspace(q2,t_start(j,2),nq);
        d3=linspace(q3,t_start(j,3),nq);
        
        %checking collision with obstacles and self-collisions
        isColl=0;
        for i=1:1:nq
            isColl=isColl + isRobotCollided([d1(i),d2(i),d3(i),q4, q5, q6], map, robot, prism1_pt1, prism1_pt2, prism2_pt1, prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2);
        end
        
        %updating child and parent array if no collisions are found
        if(isColl==0)
            t_start=[t_start; q];
            t_start_parent=[t_start_parent, j];
        end
        
        %checking with goal
        min_distance=10000;
        j=0;
        for i=1:1:size(t_goal,1)
            distance=pdist([q; t_goal(i,1:6)], 'Euclidean');
            if(distance<min_distance)
                min_distance=distance;
                j=i;
            end
        end
        
        d1=linspace(q1,t_goal(j,1),nq);
        d2=linspace(q2,t_goal(j,2),nq);
        d3=linspace(q3,t_goal(j,3),nq);
        
        isColl=0;
        for i=1:1:nq
            isColl=isColl + isRobotCollided([d1(i),d2(i),d3(i),q4, q5, q6], map, robot, prism1_pt1, prism1_pt2, prism2_pt1, prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2);
        end
        
        if(isColl==0)
            t_goal=[t_goal; q];
            t_goal_parent=[t_goal_parent, j];
        end
        
        %if the current configuration is connected to both start and goal,
        %terminate the loop
        if(t_goal(end,1:6)==t_start(end,1:6))
            break;
        end
    end
end


%computing final path
if(count<1000)
    path_1=stitch(size(t_start,1),t_start,t_start_parent);
    path_1=flip(path_1);
    path_2=stitch(size(t_goal,1),t_goal,t_goal_parent);
    path=[path_1; path_2(2:end,1:6)];
    return
end

return




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  Algortihm Ends Here               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

%function to generate random points
function [r] = randgen(min,max)
rng('shuffle');

r = (max-min).*rand(1,1)+min;
end

%stitching path using backtracking via child and parent array
function [path] = stitch(j,child, parent)
val_1=child(j,1:6);
val_2=parent(j);
if(val_1==child(1,1:6))
    path = child(1,1:6);
    return
end
path = [child(j,1:6);stitch(val_2, child, parent)];
end

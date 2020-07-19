function [path]=release(pose, angle,S)
load('robot.mat');
n=size(pose,1);                         % size of path received

S(3,4)=S(3,4)-80;                       % locating point on the cube
a=calculateIK_sol(S);
a(:,6)=17;
[jointPositions,T0i] = calculateFK_sol(a, robot);

path=pose;
q5=-1.4+ path(n,1)-angle;               % calculate orientation of goal faces with respect to gripper

if(q5<-1.9)
    q5=q5+pi/2;                         % rotate gripper within joint limits
end

path(n+1,:)=path(n,:);
path(n+1,5)= q5;                            % align gripper with goal configuration
path(n+1,6)=17;                                 
path(n+1,4)=acos(dot(T0i(1:3,1,4),[0;0;1]));    %  make gripper vertical

path(n+2,1:6)=a;                            % move gripper down towards the goal
path(n+2,4:6)=path(n+1,4:6);

path(n+3,:)=path(n+2,:);                    
path(n+3,6)= 10;                            % release the block

path(n+4,:)=path(n+1,:);                    
path(n+5,:)=path(n,:);                      % return to position above the goal position
return

end
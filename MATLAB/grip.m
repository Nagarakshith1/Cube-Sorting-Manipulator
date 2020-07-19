function [path]=grip(pose, angle,S)
load('robot.mat');
n=size(pose,1);                         % size of path received

S(3,4)=S(3,4)-80;                   % locating point on the cube
a=calculateIK_sol(S);               
a(:,6)=17;
[jointPositions,T0i] = calculateFK_sol(a, robot);

path=pose;
q5=-1.4+ path(n,1)-angle;           % calculate orientation of cube faces with respect to gripper

if(q5<-1.9)
    q5=q5+pi/2;                     % rotate gripper within joint limits
end

path(n+1,:)=path(n,:);
path(n+1,5)= q5;                      %  align gripper with the cube faces
path(n+1,6)=10;                         % open gripper
path(n+1,4)=acos(dot(T0i(1:3,1,4),[0;0;1]));    % make gripper vertical 


path(n+2,1:6)=a;
path(n+2,4:6)=path(n+1,4:6);            % move the wrist center down towards the cube

path(n+3,:)=path(n+2,:);
path(n+3,6)= 17;                        % pick up the cube

path(n+4,:)=path(n,:);                  % return to position above the start point
return

end
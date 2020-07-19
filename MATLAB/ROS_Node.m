%% Setup
rosshutdown
close all
addpath('utils')
addpath('maps')

profile on
%%
%the transformation matrices received are those of points 80 mm above the
%cubes

rosinit('192.168.43.182');                                              %% initlaize ROS on the common network

start_capture=rossubscriber('/start_tf','std_msgs/Float32MultiArray');  %% subscriber to collect start point
c=receive(start_capture,10);

goal_capture=rossubscriber('/goal_tf','std_msgs/Float32MultiArray');    %% subscriber to collect goal point
g=receive(goal_capture,10);

angle_capture=rossubscriber('/start_angle','std_msgs/Float32MultiArray');  %% subscriber to collect cube orientation
a=receive(angle_capture,10);

n=size(c.Data,1)/12;                %% number of blocks to be displaced   

for i= 1:n
S(:,:,i)=eye(4);

S(1,:,i)=c.Data(12*(i-1)+1:12*(i-1)+4);     % storing arrays as matrices
S(2,:,i)=c.Data(12*(i-1)+5:12*(i-1)+8);
S(3,:,i)=c.Data(12*(i-1)+9:12*(i-1)+12);        
S(4,:,i)=[0,0,0,1];

G(:,:,i)=eye(4);

G(1,:,i)=g.Data(12*(i-1)+1:12*(i-1)+4);
G(2,:,i)=g.Data(12*(i-1)+5:12*(i-1)+8);
G(3,:,i)=g.Data(12*(i-1)+9:12*(i-1)+12);
G(4,:,i)=[0,0,0,1];

angle(i)=a.Data(i);

start(i,:)=zeros(1,6);
start(i,1:5)=calculateIK_sol(S(:,:,i));     % joint variables for the first three joints
start(i,6)=17;

goal(i,:)=zeros(1,6);
goal(i,1:5)=calculateIK_sol(G(:,:,i));     
end
%%
load 'robot.mat' robot

map = loadmap('maps/map_final.txt');

grid on 
hold on

figure(1);
plotmap(map)


%% Calculate the path
path=start(1,:);                            % get to the first cube

for i=1:n
[path]=grip(path,angle(i),S(:,:,i));            % pick up block
[path1]=rrt(map, path(end,:), goal(i,:));       % generate apth to the destiantion

k=size(path1,1);
    for j=1:k
        path(end+1,:)=path1(j,:);       % append generated path
    end
    
[path]=release(path,angle(i),G(:,:,i));     % place the cube in desired locaiton

if(i<n)
[path2]=rrt(map,path(end,:),start(i+1,:));     % generate path to start location of next cube 

k=size(path2,1);
    for j=1:k
        path(end+1,:)=path2(j,:);           % append generated path
    end
end

end
profile off

%% Send the path

split=zeros((size(path,1)*6)+1,1);
split(1,1)=size(path,1);

for i=1:size(path,1)
    for j=1:6
        split((i-1)*6+j+1,1)=path(i,j);     % split the path into an array
    end
end

while(1)
planner=rospublisher('/path','std_msgs/Float32MultiArray');     % publisher to send the path generated
path=rosmessage(planner);
path.Data=split;
send(planner, path);                                % publish onto topic 'path'
end
rosshutdown
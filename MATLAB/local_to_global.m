function [robot_global_pt1, robot_global_pt2] = local_to_global(A_1, A_2, A_3, A_5, prism1_pt1, prism1_pt2, prism2_pt1, prism2_pt2, prism3_pt1, prism3_pt2, prism4_pt1, prism4_pt2)

s=(size(prism1_pt1,2)+size(prism2_pt1,2)+size(prism3_pt1,2)+size(prism4_pt1,2))/3;
robot_global_pt1=zeros(s,3);
robot_global_pt2=zeros(s,3);

j=1;

%transforming prism lines to frame_0
for i=1:3:size(prism1_pt1,2)-2
    d=A_1*[prism1_pt1(i:i+2)';1];
    robot_global_pt1(j,1:3)=d(1:3)';
    d1=A_1*[prism1_pt2(i:i+2)';1];
    robot_global_pt2(j,1:3)=d1(1:3)';
    j=j+1;
end

for i=1:3:size(prism2_pt1,2)-2
    d=A_2*[prism2_pt1(i:i+2)';1];
    robot_global_pt1(j, 1:3)=d(1:3)';
    d1=A_2*[prism2_pt2(i:i+2)';1];
    robot_global_pt2(j,1:3)=d1(1:3)';
    j=j+1;
end

for i=1:3:size(prism3_pt1,2)-2
    d=A_3*[prism3_pt1(i:i+2)';1];
    robot_global_pt1(j,1:3)=d(1:3)';
    d1=A_3*[prism3_pt2(i:i+2)';1];
    robot_global_pt2(j,1:3)=d1(1:3)';
    j=j+1;
end

for i=1:3:size(prism4_pt1,2)-2
    d=A_5*[prism4_pt1(i:i+2)';1];
    robot_global_pt1(j,1:3)=d(1:3)';
    d1=A_5*[prism4_pt2(i:i+2)';1];
    robot_global_pt2(j,1:3)=d1(1:3)';
    j=j+1;
end

end
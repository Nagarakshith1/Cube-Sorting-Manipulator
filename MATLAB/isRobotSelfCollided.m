function [self_coll]=isRobotSelfCollided(prism_a, prism_b_pt1, prism_b_pt2, A_b_a)

self_coll=0;
prism_b_a_1=zeros((size(prism_b_pt1,2)/3),1);
prism_b_a_2=zeros((size(prism_b_pt1,2)/3),1);

j=1;
for i=1:3:(size(prism_b_pt1,2)-2)
    d=A_b_a*[(prism_b_pt1(i:i+2))';1];
    prism_b_a_1(j,1:3)=d(1:3)';
    d_1=A_b_a*[(prism_b_pt2(i:i+2))';1];
    prism_b_a_2(j,1:3)=d_1(1:3)';
    j=j+1;
end

collision=detectCollision(prism_b_a_1,prism_b_a_2,prism_a);

if(sum(collision)>0)
    self_coll=1;
end

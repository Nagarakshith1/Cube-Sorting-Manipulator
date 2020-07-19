function [q, isPos, numRunsEnd] = calculateIK_sol(T0e)
% CALCULATEIK_SOL This function calculates the inverse kinematics for the
%   Lynx manipulator arm. It is the official solution for the MEAM520
%   assignments.
%
%   If the problem is fully feasible, q is all the solutions that satisfy
%   the joint limits. If it is position but not orientation feasible, q is
%   all the solutions to the "closest" problem. If the problem is position
%   infeasible, it is empty ([]).
%
%   The "closest" problem is found by project the infeasible z-axis onto
%   the feasible plane and then projecting the infeasible y-axis onto the
%   feasible plane.
%
% AUTHOR:
%   Dr. Cynthia Sung (crsung@seas.upenn.edu)
%   Modified by Gedaliah Knizhnik (knizhnik@seas.upenn.edu) 10/1/19
%
% INPUT:
%   T - 4 x 4 homogeneous transformation matrix, representing
%               the end effector frame expressed in the base (0) frame
%               (position in mm)
%
% OUTPUT:
%   q          - a n x 5 vector of joint inputs [q1,q2,q3,q4,q5] (rad)
%                which are required for the Lynx robot to reach the given
%                transformation matrix T. Each row represents a single
%                solution to the IK problem.
%                   If the problem is position infeasible, q should be
%                   empty. If the problem is orientation infeasible, q
%                   should be the "closest solution."
%   isPos      - a boolean set to true if the provided
%                transformation T is achievable by the Lynx robot as given,
%                ignoring joint limits

%% Cheating Prevention

persistent numRuns

% If the function hasn't been called before, initialize the counter
if isempty(numRuns)
    numRuns = 0;
end

% Count this as a use of the solution code and store it for output
numRuns = numRuns + 1;
numRunsEnd = numRuns;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lynx Parameters

% Assume the pose is reachable and check along the way.
isPos = 1;
q = [];

% Lynx ADL5 constants in mm
d1 = 76.2; % base height (table to center of joint 2) 69.85
a2 = 146.05; % shoulder to elbow length
a3 = 187.325; %elbow to wrist length 190.5
d5 = 76.2; %wrist to base of gripper
lg = 28.575; %length of gripper

% Joint limits
lowerLim = [-1.4, -1.2, -1.8, -1.9, -2.0, -15]; % Lower joint limits in radians (grip in mm (negative closes more firmly))
upperLim = [ 1.4,  1.4,  1.7,  1.7,  1.5,  30]; % Upper joint limits in radians (grip in mm)


%% Check Feasibility and Find "Closest" Problem

% Get the wrist center assuming the orientation is feasible
%wc = T0e*[0;0;-(d5+lg);1];     m
wc=T0e*[0;0;0;1];

% We check for feasibility by checking that the z-axis of the desired
% end-effector frame is in the same plane as the vector from the origin to
% the wrist center and the z0 axis.

tol = 1e-3; %Yeah, it's a random choice...

% Get the normal to the plane
 normal = cross(wc(1:3),[0;0;1]);
%normal = cross(T0e(1:3,4),[0;0;1]);
unitNormal = normal/norm(normal);

% If the vector is out of plane, find the "closest problem"
%if(abs(dot(T0e(1:3,3),unitNormal))>tol)        m
if(0)
    % Mark the problem as "infeasible"
    isPos = 0;

    % Project the Z axis onto the feasible plane
    feasibleZ = T0e(1:3,3) - dot(T0e(1:3,3),unitNormal)*unitNormal;
        feasibleZ = feasibleZ/norm(feasibleZ);
    % Project the Y azis onto the plane normal to Z
    feasibleY = T0e(1:3,2) - dot(T0e(1:3,2),feasibleZ)*feasibleZ;
        feasibleY = feasibleY/norm(feasibleY);
    %  Get the X axis
    feasibleX = cross(feasibleY,feasibleZ);

    % Assemble the "closest" problem
    T0e(1:3,1:3) = [feasibleX,feasibleY,feasibleZ];

    % Get the wrist center correctly
    %wc = T0e*[0;0;-(d5+lg);1];     m
    wc=T0e*[0;0;0;1];
end

% Extract wrist center variables
wcX = wc(1);
wcY = wc(2);
wcZ = wc(3);

% Two possible solutions for joint 1 and joint 3 gives a total of 4
% solutions for the first three joints
q1([1,2],1) = atan2(wcY,wcX); %Note this is always possible physically and mathematically!
if(q1(1)>0)
    q1([3,4],1) = q1(1) - pi;
else
    q1([3,4],1) = q1(1) + pi;
end
q3(1,1) = -pi/2 - acos( (-a2^2-a3^2+wcX^2+wcY^2+(wcZ-d1)^2) / (2*a2*a3) );

% Note that this is only possible geometrically if the wrist center is not
% too close to or too far from the origin of frame 2 (the second joint).
% Mathematically, we see that this is only possible if the portion inside
% acos is between -1 and 1.  This gives us our first check!

(-a2^2-a3^2+wcX^2+wcY^2+(wcZ-d1)^2) / (2*a2*a3);

if(abs((-a2^2-a3^2+wcX^2+wcY^2+(wcZ-d1)^2) / (2*a2*a3))>1)
    isPos = 0;
    return;
end

q3(2,1) = -pi-q3(1,1);

q3([3,4],1) = pi - q3([1,2],1);

% Each pair of q1 and q3 has one valid q2
for(i=1:2)
   % q2 is the amounted needed to rotate (about z1) the position  of the wrist center
   % if q1 and q3 were set but q2 were zero (alpha), to the actual position of
   % the wrist center (beta)
   alpha = atan2(a3*sin(-pi/2-q3(i,1)),a2+a3*cos(-pi/2-q3(i,1)));
   beta = atan2(wcZ-d1,sqrt(wcX^2+wcY^2));
   q2(i,1) = pi/2+alpha - beta;
end

q2([3,4],1) = -q2([1,2],1);

for(i = 1:4)

    % Now plug the first three joint angles into FK
    R03 = [ cos(q2(i) + q3(i))*cos(q1(i)), -sin(q2(i) + q3(i))*cos(q1(i)), -sin(q1(i));
            cos(q2(i) + q3(i))*sin(q1(i)), -sin(q2(i) + q3(i))*sin(q1(i)),  cos(q1(i));
                      -sin(q2(i) + q3(i)),            -cos(q2(i) + q3(i)),          0];

    R05 = T0e(1:3,1:3);
    R35 = R03'*R05;

    % We can also solve R35 symbolically using forward kinematics to get:
    %R35 = [   x   x  c4 ;
    %          x   x  s4 ;
    %        -s5 -c5  0];

    % We can combine these two representations to get:
    %q4(i,1) = atan2(R35(2,3),R35(1,3));
    %q5(i,1) = atan2(-R35(3,1),-R35(3,2));
    %q4(i,1)=0.5;
    q4(i,1)=acos(dot(R03(1:3,1),[0;0;-1]))-(pi/2);
    q5(i,1)=0;

%     Note that it's always mathematically possible to find q4 and q5,
%     since atan2 always returns a value. However, our robot doesn't have
%     6 DOF, so we know that this doesn't always result in the correct
%     transformation matrix. You can easily see this visually, by trying to
%     place the end-effector at the zero pose, then have it point to the
%     left.

end

% Assemble results and wrap to (-pi,pi]
q = wrapToPi([q1,q2,q3,q4,q5]);

%% Check the Joint Limits
upperLimsCheck = ones(size(q,1),1)*upperLim(1:5);
lowerLimsCheck = ones(size(q,1),1)*lowerLim(1:5);

inLims = (q < upperLimsCheck) & (q > lowerLimsCheck);
toKeep = (sum(inLims,2) == 5);

q = q(toKeep,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

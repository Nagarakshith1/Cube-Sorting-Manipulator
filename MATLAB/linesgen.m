function [point1,point2] = linesgen(points)

step=3;         %space between discretized lines of the robot
xrange = points(1):step:points(4);
yrange = points(2):step:points(5);
point1=zeros(1,3*(size(xrange,2)+2*size(yrange,2)));
point2=zeros(1,3*(size(xrange,2)+2*size(yrange,2)));

%modelling the six faces of the prism
j=1;
for i = yrange
    p = [points(1),i,points(3)];
    point1(1,j:j+2) = p(1:3);
    j=j+3;
end

k=1;
for i = yrange
    p = [points(1),i,points(6)];
    point2(1,k:k+2) = p(1:3);
    k=k+3;
end

for i = yrange
    p = [points(4),i,points(3)];
    point1(1,j:j+2) = p(1:3);
    j=j+3;
end
for i = yrange
    p = [points(4),i,points(6)];
    point2(1,k:k+2) = p(1:3);
    k=k+3;
end

%for x range indexing
for i = xrange
    p = [i,points(2),points(3)];
    point1(1,j:j+2) = p(1:3);
    j=j+3;
end
for i = xrange
    p = [i,points(2),points(6)];
    point2(1,k:k+2) = p(1:3);
    k=k+3;
end

for i = xrange
    p = [i,points(5),points(3)];
    point1(1,j:j+2) = p(1:3);
    j=j+3;
end
for i = xrange
    p = [i,points(5),points(6)];
    point2(1,k:k+2) = p(1:3);
    k=k+3;
end

%for yrange indexing
for i = yrange
    p = [points(1),i,points(3)];
    point1(1,j:j+2) = p(1:3);
    j=j+3;
end
for i = yrange
    p = [points(4),i,points(3)];
    point2(1,k:k+2) = p(1:3);
    k=k+3;
end

for i = yrange
    p = [points(1),i,points(6)];
    point1(1,j:j+2) = p(1:3);
    j=j+3;
end
for i = yrange
    p = [points(4),i,points(6)];
    point2(1,k:k+2) = p(1:3);
    k=k+3;
end

end

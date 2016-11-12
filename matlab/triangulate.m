function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%

p1 = [p1 zeros(size(p1,1),1) ones(size(p1,1),1)];
p2 = [p2 zeros(size(p2,1),1) ones(size(p2,1),1)];

x1 = [M1(1,1)-M1(3,1)*p1(:,1)  M1(1,2)-M1(3,2)*p1(:,1)  M1(1,3)-M1(3,3)*p1(:,1)  M1(1,4)-M1(3,4)*p1(:,1)];

y1 = [M1(2,1)-M1(3,1)*p1(:,2)  M1(2,2)-M1(3,2)*p1(:,2)  M1(2,3)-M1(3,3)*p1(:,2)  M1(2,4)-M1(3,4)*p1(:,2)];

x2 = [M2(1,1)-M2(3,1)*p2(:,1)  M2(1,2)-M2(3,2)*p2(:,1)  M2(1,3)-M2(3,3)*p2(:,1)  M2(1,4)-M2(3,4)*p2(:,1)];

y2 = [M2(2,1)-M2(3,1)*p2(:,2)  M2(2,2)-M2(3,2)*p2(:,2)  M2(2,3)-M2(3,3)*p2(:,2)  M2(2,4)-M2(3,4)*p2(:,2)];

D = [x1;
     y1;
     x2;
     y2];
 
[U,S,V] = svd(D);
P = V(:,end);
error = S(3,3)/S(4,4);


end


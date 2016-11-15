function [ x2temp, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup
%% Initialize

% Line can be computed with one point as the other point lies at the origin
% Format as following: [x y z]*[a b c]';

l = F*[x1 y1 1]'; % [a b c]
% Normalize
s = l./sqrt(l(1)^2 + l(2)^2);
v1 = [x1 y1];
v2=[-s(2) s(1) s(2)*x1-s(1)*y1]';
proj=round(cross(s,v2)); 
l = l/l(1);

% Apply window
win = 5;

% Gaussian Filter
w = fspecial('gaussian',[2*win+1,2*win+1],2.5);

X1 = round(proj(1)-win:proj(1)+win);
Y1 = round(proj(2)-win:proj(2)+win);
sim = size(im1);
patch1 = w.*im1(Y1,X1);

error = 1000;
threshold =10;

x2 = 0;
y2 = 0;
for i = proj(2)-20:proj(2)+20
  x2temp = round(-l(2)*i - l(3));
  v2=[-s(2) s(1) s(2)*x2temp-s(1)*i]';
  proj=round(cross(s,v2)); 
  X2 = round(proj(1)-win:proj(1)+win);
  Y2 = round(proj(2)-win:proj(2)+win);
   
   if (sum(X2 <= 0) == 0) && (sum(X2 > size(im2,1)) == 0) 
       	patch2 = w.*im2(Y2,X2);
	Temp_error = norm(patch2 - patch1);
	% check if error is smaller than before and if distance between points
	% is smaller than threshold
	if (Temp_error < error) && (norm([x1-x2temp y1-i]) < threshold)
        	error = Temp_error;
       		x2 = proj(1);
       		y2 = proj(2);
   	end
   end
end

end


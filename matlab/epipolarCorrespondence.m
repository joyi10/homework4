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

[sy,sx]= size(im2);
% line = F*[x1 y1 1]'; % [a b c]

l = [x1 y1 1]*F; % [a b c]
% Normalize
% s = l./sqrt(x1^2 + y1^2);

l = l/l(1)

 % l = l./s

%  if l(1) ~= 0
   % ye = sy;
    %ys = 1;
    %xe = -(l(2) * ye + l(3))/l(1);
    %xs = -(l(2) * ys + l(3))/l(1)
  %else
   % xe = sx
    %xs = 1
    %ye = -(l(1) * xe + l(3))/l(2);
    %ys = -(l(1) * xs + l(3))/l(2)
  %end
% use one line and dont sweep along x. Sweep along y because its very
% vertical

% Apply window
win = 10;

% Gaussian Filter
w = fspecial('gaussian',[2*win+1,2*win+1],2.5);

X1 = round(x1-win:x1+win);
Y1 = round(y1-win:y1+win);

%  im1(X1,Y1)
patch1 = w.*im1(X1,Y1);


error = 1000;
threshold =10;

for i = 1+win:size(im2,2)-win
  x2temp = round(-l(2)*i - l(3));
  X2 = round(x2temp-win:x2temp+win)
   Y2 = round(i-win:i+win)
   
   if (sum(X2 <= 0) == 0) && (sum(X2 > size(im2,1)) == 0) 
       	patch2 = w.*im2(X2,Y2);
	Temp_error = norm(patch2 - patch1);
	% check if error is smaller than before and if distance between points
	% is smaller than threshold
	norm([x1-x2temp y1-i])
	if (Temp_error < error) && (norm([x1-x2temp y1-i]) < threshold)
        	error = Temp_error;
       		x2 = x2temp;
       		y2 = i;
   	end
   end
end
%%
% save('q2_6.mat','F','p1','p2','P');
end


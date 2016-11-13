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
%%

% Line can be computed with one point as the other point lies at the origin
% Format as following: [x y z]*[a b c]';

line = F*[x1 y1 1]'; % [a b c]
% Normalize
% line = line./sqrt(x1^2 + y1^2);

line = line/line(1);

% use one line and dont sweep along x. Sweep along y because its very
% vertical

% Apply window
window = 10;
X1 = x1-window:x1+window;
Y1 = y1-window:y1+window;
patch1 = w.*im1(X,Y);

% Gaussian Filter
w = fspecial('gaussian',[2*window+1,2*window+1],2);

error = 1000;
threshold =5;

for i = 1+window:size(im2,2)-window
   x2temp = round(-line(2)*i - line(3));
   X2 = x2temp-window:x2temp+window;
   Y2 = i-window:i+window;
   patch2 = w.*im2(X2,Y2);
   Temp_error = norm(patch2 - patch1);
   % check if error is smaller than before and if distance between points
   % is smaller than threshold
   if (Temp_error < error) && (norm([x1-x2temp y1-i]) < threshold)
       error = Temp_error;
       x2 = x2temp;
       y2 = i;
   end
end
%%
% save('q2_6.mat','F','p1','p2','P');
end


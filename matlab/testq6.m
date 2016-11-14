%% Load files
im1 = im2double(imread('im1.png'));
im2 = im2double(imread('im2.png'));
load data/some_corresp.mat
load data/intrinsics.mat
M = max(size(im1,1),size(im1,2));   

%% Run Epipolar

F = eightpoint(pts1, pts2, M);
[coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F)



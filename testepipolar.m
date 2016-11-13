%% Load Stuff
load q2_5.mat
im1 = im2double(imread('im1.png'));
im2 = im2double(imread('im2.png'));
load data/some_corresp.mat
load data/intrinsics.mat

%% Test correspondence
% [x2, y2] = epipolarCorrespondence(im1, im2, F, x1, y1)
[coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F)
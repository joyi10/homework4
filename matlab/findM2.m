% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q2_5.mat

im1 = im2double(imread('im1.png'));
im2 = im2double(imread('im2.png'));
load data/some_corresp.mat
load data/intrinsics.mat

%%

M = max(size(im1,1),size(im1,2));

F = sevenpoint(pts1, pts2, M);

for i = 1:numel(F)
    E{i,1} = essentialMatrix(F{i,1}, K1, K2);
    M2s{i,1} = camera2(E{i,1});
end

M1 = [eye(3) zeros(3,1)];

[P, error] = triangulate(M1, pts1, M2, pts2);



save('q2_5.mat');

% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q2_5.mat

im1 = im2double(imread('im1.png'));
im2 = im2double(imread('im2.png'));
load data/some_corresp.mat
load data/intrinsics.mat

M = max(size(im1,1),size(im1,2));   

%% Sevenpoint

Fcell = sevenpoint(pts1, pts2, M);

for i = 1:numel(F)
<<<<<<< Updated upstream
    E{i,1} = essentialMatrix(F{i,1}, K1, K2);
    M2s{i,1} = camera2(E{i,1});
=======
    Ecell{i,1} = essentialMatrix(F{i,1}, K1, K2);
>>>>>>> Stashed changes
    figure
    displayEpipolarF(im1, im2, F{i,1})
end

F = Fcell{1,1};
E = essentialMatrix(F, K1, K2);
M2s = camera2(E);

%% Eightpoint

F = eightpoint(pts1, pts2, M);

E = essentialMatrix(F, K1, K2);
M2s = camera2(E);
figure
displayEpipolarF(im1, im2, F)

%% 

M1 = [eye(3) zeros(3,1)];
 
for i = 1:size(M2s,3);
    [Pm(:,:,i), error(i)] = triangulate(M1, pts1, M2s(:,:,i), pts2);
end
% If this does not work, check the value of Z for Pm. If less than zero,
% then it does not work
[~,I] = min(error);
P = Pm(:,:,I);
M2 = M2s(:,:,I);
p1 = pts1;
p2 = pts2;
save('q2_5.mat','M2','p1','p2','P');

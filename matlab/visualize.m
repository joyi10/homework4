% Q2.7 - Todo:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

load templeCoords.mat
load q2_5.mat
im1 = im2double(imread('im1.png'));
im2 = im2double(imread('im2.png'));
load data/intrinsics.mat
M = max(size(im1,1),size(im1,2));   
F = eightpoint(pts1, pts2, M);
x2 = zeros(size(x1,1),1);
y2 = zeros(size(x1,1),1);

for i = 1:numel(x1)
   [x2(i,1), y2(i,1)] = epipolarCorrespondence(im1, im2, F, x1(i), y1(i));
end
pts1 = [x1 y1];
pts2 = [x2 y2];
M1 = [eye(3) zeros(3,1)];
E = essentialMatrix(F, K1, K2);
 
for i = 1:size(M2,3);
    [Pm, error] = triangulate(K1*M1, pts1, K2*M2(:,:,i), pts2);
    if all(Pm(:,3)) > 0
       P = Pm;
       M2 = M2(:,:,i);
    end       
    
end
% If this does not work, check the value of Z for Pm. If less than zero,
% then it does not work
%[~,I] = min(error);
%P = Pm(:,:,I)';
%M2 = M2s(:,:,I);

% visualize acquired 3D points

M1 = K1*M1;
M2 = K2*M2;
save('q2_7.mat','F', 'M1', 'M2');
scatter3(P(:,1),P(:,2),P(:,3))


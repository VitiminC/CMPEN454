close all;
% figure out camera location and vector for each viewing ray
% although c1 and c2 are 3,39, every column is the same since c1 and c2
% never change location
c1 = zeros(3,39);
c2 = zeros(3,39);
v1 = zeros(3,39);
v2 = zeros(3,39);
% create an array to store results
result= zeros(3,39);

for pix = 1:39
    % get the trans matrix from the R matrix (ignore the var name 'translation', it's R matrix)
    trans = [[1 0 0 ; 0 1 0; 0 0 1;0 0 0] translation(:,4)];
    trans2 = [[1 0 0 ; 0 1 0; 0 0 1; 0 0 0] translation2(:,4)];
    % calculate C1 and C2 (we forgot there is a position parameter)
    c1(:,pix) = (-rotation(1:3,1:3).' * trans(1:3,4));
    c2(:,pix) = (-rotation2(1:3,1:3).' * trans2(1:3,4));
    % derive the viewing rays
    v1(:,pix) = (rotation(1:3,1:3).'* inv(parameter1.Kmat) * temp3(:,pix));
    v2(:,pix) = (rotation2(1:3,1:3).'* inv(parameter2.Kmat) * dtemp3(:,pix));
    v_vec = [v1(:,pix),-v2(:,pix)];
    v_vec = v_vec(1:2,1:2);
    % calculate lambda and reconstruct 3D points
    lambda = inv(v_vec)*(c2(1:2,pix) - c1(1:2,pix));
    result(:,pix) = c1(:,pix) + v1(:,pix)*lambda(1);
end
% calculate difference with the original 3D points
disp('The difference between the first 8 of the reconstructed points and the original points are: ');
disp(result(:,1:8) - points(:,1:8));
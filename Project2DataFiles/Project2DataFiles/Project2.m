% 3.1 in the project
% First load the images, parameters, and points
parameter1 = load('Parameters_V1_1.mat');
parameter1 = parameter1.Parameters;
parameter2 = load('Parameters_V2_1.mat');
parameter2 = parameter2.Parameters;
points = load('mocapPoints3D.mat');
% extract 3D points
points = points.pts3D;
% store results of each step, temp for left image, dtemp for right image
temp = zeros(4,39);
temp2 = zeros(3,39);
temp3 = zeros(3,39);

dtemp = zeros(4,39);
dtemp2 = zeros(3,39);
dtemp3 = zeros(3,39);

% go through each point using left camera parameters
for point = 1:39
    % extract points and matrix from intrinsic parameters
    tDpoint = points(:,point);
    translation = zeros(4,4);
    translation(1:3,:) = parameter1.Pmat;
    translation(4,4) = 1;
    rotation = zeros(4,4);
    rotation(1:3,1:3) = parameter1.Rmat;
    rotation(4,4) = 1;
    % world to camera transition
    temp(:,point) =  translation * [tDpoint; 1];
    % camera to film transition
    temp2(1,point) = temp(1,point)/temp(3,point);
    temp2(2,point) = temp(2,point)/temp(3,point);
    temp2(3,point) = 1;
    % film to pixel transition
    temp3(:,point) = parameter1.Kmat * temp2(:,point);

end


% repeat the same procedure for right camera
for point = 1:39
    tDpoint = points(:,point);
    translation2 = zeros(4,4);
    translation2(1:3,:) = parameter2.Pmat;
    translation2(4,4) = 1;
    rotation2 = zeros(4,4);
    rotation2(1:3,1:3) = parameter2.Rmat;
    rotation2(4,4) = 1;
    dtemp(:,point) =  translation2 * [tDpoint; 1];

    dtemp2(1,point) = dtemp(1,point) / dtemp(3,point);
    dtemp2(2,point) = dtemp(2,point) / dtemp(3,point);
    dtemp2(3,point) = 1;

    dtemp3(:,point) = parameter2.Kmat * dtemp2(:,point);

end

% store results
res1 = temp3(1:2,:);
res2 = dtemp3(1:2,:);

% plot points on images
im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
figure(1); imagesc(im);
hold on;
for i=1:size(res1,2)
    h = plot(res1(1,i),res1(2,i),'*'); 
    set(h,'Color','r','LineWidth',2);
end
hold off;
figure(2); imagesc(im2);
hold on;
for i=1:size(res2,2)
    h = plot(res2(1,i),res2(2,i),'*'); 
    set(h,'Color','r','LineWidth',2);
end
hold off;
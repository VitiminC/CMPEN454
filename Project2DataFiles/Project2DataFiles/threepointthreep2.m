% load images
im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
figure(1); imagesc(im);
% for your convenience, we have manually selected points for the person,
% dorrway, and the camera, and stored them here
selected_xpts_l = [1.0e+03 *[1.1250;1.1169] [568.7451;558.0487] 1.0e+03 *[1.4619;1.4619]];
selected_ypts_l = [[290.3837;545.7326] [392.9419;717.3605] [256.8953;256.8953]];
% plotting the points
hold on;
for j=1:3
for i=1:2
    h = plot(selected_xpts_l(i,j),selected_ypts_l(i,j),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(selected_xpts_l(i,j),selected_ypts_l(i,j),sprintf('%d',(j-1)*2+i));
end
end
hold off;

figure(2); imagesc(im2);
selected_xpts_r = [[218.7564; 245.0128] 1.0e+03 * [1.0393;1.0393] [717.6282;717.6282]];
selected_ypts_r = [[178.8138; 510.1487] [345.7459;775.7225] [156.0504;156.0504]];
hold on;
for j=1:3
for i=1:2
    h = plot(selected_xpts_r(i,j),selected_ypts_r(i,j),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(selected_xpts_r(i,j),selected_ypts_r(i,j),sprintf('%d',(j-1)*2+i));
end
end
hold off;

% go through each task (doorway, person, camera)
for ind=1:3
    % load points
    xpts_l = selected_xpts_l(:,ind);
    ypts_l = selected_ypts_l(:,ind);
    xpts_r = selected_xpts_r(:,ind);
    ypts_r = selected_ypts_r(:,ind);

    pts_l = [xpts_l.'; ypts_l.'; [1 1]];
    pts_r = [xpts_r.'; ypts_r.'; [1 1]];
    
    % similar to 3.2, we reconstruct the 3D points
    c1 = zeros(3,2);
    c2 = zeros(3,2);
    v1 = zeros(3,2);
    v2 = zeros(3,2);
    result= zeros(3,2);
    
    for pix = 1:2
        % reconstruct the 3D points
        trans = [[1 0 0 ; 0 1 0; 0 0 1;0 0 0] translation(:,4)];
        trans2 = [[1 0 0 ; 0 1 0; 0 0 1; 0 0 0] translation2(:,4)];
        c1(:,pix) = (-rotation(1:3,1:3).' * trans(1:3,4));
        c2(:,pix) = (-rotation2(1:3,1:3).' * trans2(1:3,4));
        v1(:,pix) = (rotation(1:3,1:3).'* inv(parameter1.Kmat) * pts_l(:,pix));
        v2(:,pix) = (rotation2(1:3,1:3).'* inv(parameter2.Kmat) * pts_r(:,pix));
        v_vec = [v1(:,pix),-v2(:,pix)];
        v_vec = v_vec(1:2,1:2);
        lambda = inv(v_vec)*(c2(1:2,pix) - c1(1:2,pix));
        result(:,pix) = c1(:,pix) + v1(:,pix)*lambda(1);
    end
    % once we have the 3D points, we just calculate the difference along
    % the z-axis for each pair of points
    switch ind
        case 1
            disp('Calculating height of the doorway');
            disp(['Height is ' num2str(abs(result(3,1) - result(3,2)))]);
        case 2
            disp('Calculating height of the person');
            disp(['Height is ' num2str(abs(result(3,1) - result(3,2)))]);
        case 3
            disp('Calculating center of the camera');
            disp(['Result is ' num2str(result(1,1)) ',' num2str(result(2,1)) ',' num2str(result(3,1))]);
    end
end
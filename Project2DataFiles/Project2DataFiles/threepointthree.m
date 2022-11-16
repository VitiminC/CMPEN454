% load images
im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
% for the convenience, we have manually selected 3 points on the floor and the stripped wall,
% and sotred them here
figure(1); imagesc(im);
% points for the left image, plot them
selected_xpts_l = 1.0e+03 * [[1.2945;0.9760;0.3345] [1.3924;1.1544;1.6705]];
selected_ypts_l = [[795.5437;934.0860;707.3805] [129.2209;505.9651;491.3140] ];
hold on;
for j = 1:2
for i=1:3
    h = plot(selected_xpts_l(i,j),selected_ypts_l(i,j),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(selected_xpts_l(i,j),selected_ypts_l(i,j),sprintf('%d',(j-1)*3+i));
end
end
hold off;

figure(2); imagesc(im2);
% points for the right image, plot them
selected_xpts_r = [1.0e+03 *[1.3653;1.7148;0.9317] [563.3718;304.0897;842.3462]];
selected_ypts_r = [[597.1764;697.9344;890.0044] [11.8817;451.9754;360.9215]];
hold on;
for j = 1:2
for i=1:3
    h = plot(selected_xpts_r(i,j),selected_ypts_r(i,j),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(selected_xpts_r(i,j),selected_ypts_r(i,j),sprintf('%d',(j-1)*3+i));
end
end
hold off;

for ind = 1:2
    if(ind == 1)
        disp('-----Calculating plane fits to the points on the floor-----');
    else
        disp('-----Calculating plane fits to the points on the wall-----');
    end
xpts_l = selected_xpts_l(:,ind);
ypts_l = selected_ypts_l(:,ind);
xpts_r = selected_xpts_r(:,ind);
ypts_r = selected_ypts_r(:,ind);
% init variables to store the results
v1_l = zeros(3,3);
v2_r = zeros(3,3);
result_tpt= zeros(3,3);
% go through each pair of points
for pix = 1:3
    % similar to 3.2, we derive the viewing rays first, then reconstruct
    % the 3D points
    v1_l(:,pix) = (rotation(1:3,1:3).'* inv(parameter1.Kmat) * [xpts_l(pix);ypts_l(pix);1]);
    v2_r(:,pix) = (rotation2(1:3,1:3).'* inv(parameter2.Kmat) * [xpts_r(pix);ypts_r(pix);1]);
    v_vec = [v1_l(:,pix),-v2_r(:,pix)];
    v_vec = v_vec(1:2,1:2);
    lambda = inv(v_vec)*(c2(1:2,pix) - c1(1:2,pix));
    result_tpt(:,pix) = c1(:,1) + v1_l(:,pix)*lambda(1);
end
result_tpt_t = result_tpt.';
% once we have the 3D points, we calculated the plane that fit to those
% points
v1_tht = result_tpt_t(2,:) - result_tpt_t(1,:);
v2_tht = result_tpt_t(3,:) - result_tpt_t(1,:);
cp = cross(v1_tht,v2_tht);
% plane coefficients
cp = cp./norm(cp);
d = dot(cp, result_tpt_t(3,:));

disp("----— 3.3 RESULT SUMMARY -----")
disp("The three coordinates in the 3D world has coordinations (each row is a point):");
disp(result_tpt_t);
disp("The plane that fits to those points is:");
disp(['(' num2str(cp(1)) ')x + (' num2str(cp(2)) ') y + (' num2str(cp(3)) ') z + (' num2str(d) ') = 0'])
end
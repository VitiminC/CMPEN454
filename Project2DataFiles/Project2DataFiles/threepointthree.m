im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
figure(1); imagesc(im);
[xpts_l,ypts_l] = ginput(3);
hold on;
for i=1:3
    h = plot(xpts_l(i),ypts_l(i),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(xpts_l(i),ypts_l(i),sprintf('%d',i));
end
hold off;

figure(2); imagesc(im2);
[xpts_r,ypts_r] = ginput(3);
hold on;
for i=1:3
    h = plot(xpts_r(i),ypts_r(i),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(xpts_r(i),ypts_r(i),sprintf('%d',i));
end
hold off;

v1_l = zeros(3,3);
v2_r = zeros(3,3);
result_tpt= zeros(3,3);

for pix = 1:3
    v1_l(:,pix) = (rotation(1:3,1:3).'* inv(parameter1.Kmat) * [xpts_l(pix);ypts_l(pix);1]);
    v2_r(:,pix) = (rotation2(1:3,1:3).'* inv(parameter2.Kmat) * [xpts_r(pix);ypts_r(pix);1]);
    v_vec = [v1_l(:,pix),-v2_r(:,pix)];
    v_vec = v_vec(1:2,1:2);
    lambda = inv(v_vec)*(c2(1:2,pix) - c1(1:2,pix));
    result_tpt(:,pix) = c1(:,1) + v1_l(:,pix)*lambda(1);
end
result_tpt_t = result_tpt.';
v1_tht = result_tpt_t(2,:) - result_tpt_t(1,:);
v2_tht = result_tpt_t(3,:) - result_tpt_t(1,:);
cp = cross(v1_tht,v2_tht);
cp = cp./norm(cp);
d = dot(cp, result_tpt_t(3,:));

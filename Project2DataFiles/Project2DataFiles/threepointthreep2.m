im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
figure(1); imagesc(im);
[xpts_l,ypts_l] = ginput(2);

for i=1:2
    h = plot(xpts_l(i),ypts_l(i),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(xpts_l(i),ypts_l(i),sprintf('%d',i));
end
hold off;

figure(2); imagesc(im2);
[xpts_r,ypts_r] = ginput(2);
hold on;
for i=1:2
    h = plot(xpts_r(i),ypts_r(i),'*'); 
    set(h,'Color','g','LineWidth',2);
    text(xpts_r(i),ypts_r(i),sprintf('%d',i));
end
hold off;

pts_l = [xpts_l.'; ypts_l.'; [1 1]];
pts_r = [xpts_r.'; ypts_r.'; [1 1]];

c1 = zeros(3,2);
c2 = zeros(3,2);
v1 = zeros(3,2);
v2 = zeros(3,2);
result= zeros(3,2);

for pix = 1:2
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
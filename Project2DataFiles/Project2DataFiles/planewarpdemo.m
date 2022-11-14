
%quick and dirty plane warp demo using homographies
%Bob Collins  Nov 2, 2005  Penn State Univ
%

%read source image

im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
[nr,nc,nb] = size(im1);

%make new image
dest = zeros(nr,nc,nb);

%click four points in source
figure(1); colormap(gray); clf;
imagesc(im1);
axis image
xpts_l = 1.0e+03 * [0.3286;0.9811;1.5061;0.9286];
ypts_l = [705.5;926.75;709.25;600.5];
%click four points in source
figure(2); colormap(gray); clf;
imagesc(im2);
axis image

xpts_r = 1.0e+03 * [0.9362;1.6971;1.1220;0.4893];
ypts_r = [894.4171; 695.3387;527.2281;593.5876];
pts_l = [xpts_l.';ypts_l.';ones(1,4)];
pts_r = [xpts_r.';ypts_r.';ones(1,4)];

c1 = zeros(3,4);
c2 = zeros(3,4);
v1 = zeros(3,4);
v2 = zeros(3,4);
pts= zeros(3,4);

for pix = 1:4
    trans = [[1 0 0 ; 0 1 0; 0 0 1;0 0 0] translation(:,4)];
    trans2 = [[1 0 0 ; 0 1 0; 0 0 1; 0 0 0] translation2(:,4)];
    c1(:,pix) = (-rotation(1:3,1:3).' * trans(1:3,4));
    c2(:,pix) = (-rotation2(1:3,1:3).' * trans2(1:3,4));
    v1(:,pix) = (rotation(1:3,1:3).'* inv(parameter1.Kmat) * pts_l(:,pix));
    v2(:,pix) = (rotation2(1:3,1:3).'* inv(parameter2.Kmat) * pts_r(:,pix));
    v_vec = [v1(:,pix),-v2(:,pix)];
    v_vec = v_vec(1:2,1:2);
    lambda = inv(v_vec)*(c2(1:2,pix) - c1(1:2,pix));
    pts(:,pix) = c1(:,pix) + v1(:,pix)*lambda(1);
end

rec_info = zeros(1,2);
rec_info(1,1) = sqrt((pts(1,2) - pts(1,1))^2 + (pts(2,2) - pts(2,1))^2);
rec_info(1,2) = sqrt((pts(1,3) - pts(1,2))^2 + (pts(2,3) - pts(2,2))^2);
if (nr < nc)
    rec_info(1,1) = rec_info(1,1)*(nr/rec_info(1,2));
    rec_info(1,2) = nr;
else
    rec_info(1,1) = rec_info(1,1)*(nc/rec_info(1,2));
    rec_info(1,2) = nc;
end

%input rectangle in destination image
figure(2); colormap(gray); clf;
imagesc(dest);
axis image
xp1 = 0;
yp1 = 0;
xp2 = xp1+rec_info(1,1);
yp2 = yp1+rec_info(1,2);
xprimes = [xp1 xp2 xp2 xp1]';
yprimes = [yp1 yp1 yp2 yp2]';

%compute homography (from im2 to im1 coord system)
p1 = xpts; p2 = ypts;
p3 = xprimes; p4 = yprimes;
vec1 = ones(size(p1,1),1);
vec0 = zeros(size(p1,1),1);
Amat = [p3 p4 vec1 vec0 vec0 vec0 -p1.*p3 -p1.*p4; vec0 vec0 vec0 p3 p4 vec1 -p2.*p3 -p2.*p4];
bvec = [p1; p2];
h = Amat \ bvec;
fprintf(1,'Homography:');
fprintf(1,' %.2f',h); fprintf(1,'\n');

%warp im1 forward into im2 coord system 
[xx,yy] = meshgrid(1:size(dest,2), 1:size(dest,1));
denom = h(7)*xx + h(8)*yy + 1;
hxintrp = (h(1)*xx + h(2)*yy + h(3)) ./ denom;
hyintrp = (h(4)*xx + h(5)*yy + h(6)) ./ denom;
for b = 1:nb
 dest(:,:,b) = interp2(double(source(:,:,b)),hxintrp,hyintrp,'linear')/255.0;
end

%display result
imagesc(dest);


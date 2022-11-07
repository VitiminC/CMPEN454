C2coordtoC1 = rotation * trans * [trans2(:,4)];
rotC2C1 = inv(rotation2) * rotation;
c1M = parameter1.Kmat * parameter1.foclen;
c2M = parameter2.Kmat * parameter2.foclen;
c2c1skew = [0 -C2coordtoC1(3) C2coordtoC1(2); C2coordtoC1(3) 0 -C2coordtoC1(1); -C2coordtoC1(2) C2coordtoC1(1) 0];
fundamentalC2C1 = inv(c2M).'*rotC2C1(1:3,1:3) * c2c1skew * inv(c1M);

im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
figure(1); imagesc(im);
hold on;
h = plot(res1(1,30),res1(2,30)); 
set(h,'Color','r','LineWidth',4,'Marker','*');
hold off;

figure(2); imagesc(im2);
hold on;
epipolarLineOnC2 = fundamentalC2C1 * [res1(:,30);1];
x = [200:10:1600];
y = -(epipolarLineOnC2(1) * x + epipolarLineOnC2(3))/epipolarLineOnC2(2);
h = plot(x,y);
set(h,'Color','r','LineWidth',2,'Marker','*');
hold off;
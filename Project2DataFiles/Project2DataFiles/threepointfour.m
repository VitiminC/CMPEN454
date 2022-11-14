C2coordtoC1 = rotation * trans * [trans2(:,4)];
rotC2C1 = inv(rotation2) * rotation;
c1M = parameter1.Kmat * parameter1.foclen;
c2M = parameter2.Kmat * parameter2.foclen;
c2c1skew = [0 -C2coordtoC1(3) C2coordtoC1(2); C2coordtoC1(3) 0 -C2coordtoC1(1); -C2coordtoC1(2) C2coordtoC1(1) 0];
fundamentalC2C1 = inv(c2M).'*rotC2C1(1:3,1:3) * c2c1skew * inv(c1M);

im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');
colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
%overlay epipolar lines on im2
x1 = 1.0e+03 * [1.1288; 1.4303; 1.6820; 0.9298; 1.5093; 0.9795; 0.3327; 1.8722];
y1 = [293.1829; 222.9390; 571.2317; 600.5000; 711.7195; 937.0854; 708.7927; 942.9390];
x2 = 1.0e+03 * [0.2204; 0.6105; 0.8568; 0.4971; 1.1196; 1.7089; 0.9287; 1.6176];
y2 = [180.8458; 111.6816; 416.0043; 601.3646; 532.2003; 698.1945; 894.6210; 562.6326];
L = fundamentalC2C1 * [x1' ; y1'; ones(size(x1'))];
[nr,nc,nb] = size(im2);
figure(2); clf; imagesc(im2); axis image;
hold on; plot(x2,y2,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi]);
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end


%overlay epipolar lines on im1

L = ([x2' ; y2'; ones(size(x2'))]' * fundamentalC2C1)' ;
[nr,nc,nb] = size(im);
figure(1); clf; imagesc(im); axis image;
hold on; plot(x1,y1,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end
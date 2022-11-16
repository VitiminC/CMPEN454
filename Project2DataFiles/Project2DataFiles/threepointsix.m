im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

%overlay epipolar lines on im2
for f_ind = 1:2
    if(f_ind == 1)
        fundamentalMatrix = fundamentalC2C1;
    else
        fundamentalMatrix = F;
    end
    L = fundamentalMatrix * [res1(1,:);res1(2,:);ones(1,length(res1))];
    distance_l = 0;
    distance_r = 0;
    [nr,nc,nb] = size(im2);
    for i=1:length(L)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo=0; yhi=nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           numerator = abs((xhi - xlo) * (ylo - res2(2,i)) - (xlo - res2(1,i)) * (yhi - ylo));
           % Find the denominator for our point-to-line distance formula.
	       denominator = sqrt((xhi - xlo) ^ 2 + (yhi - ylo) ^ 2);
	    
	       % Compute the distance.
	       distance = numerator ./ denominator;
           distance_r = distance_r + distance;
        else
           xlo=0; xhi=nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           numerator = abs((xhi - xlo) * (ylo - res2(2,i)) - (xlo - res2(1,i)) * (yhi - ylo));
           % Find the denominator for our point-to-line distance formula.
	       denominator = sqrt((xhi - xlo) ^ 2 + (yhi - ylo) ^ 2);
	    
	       % Compute the distance.
	       distance = numerator ./ denominator;
           distance_r = distance_r + distance;
        end
    end
    
    %overlay epipolar lines on im1
    L = ([res2; ones(1,length(res2))]' * fundamentalMatrix)' ;
    [nr,nc,nb] = size(im);
    for i=1:length(L)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo=0; yhi=nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           numerator = abs((xhi - xlo) * (ylo - res1(2,i)) - (xlo - res1(1,i)) * (yhi - ylo));
           % Find the denominator for our point-to-line distance formula.
	       denominator = sqrt((xhi - xlo) ^ 2 + (yhi - ylo) ^ 2);
	    
	       % Compute the distance.
	       distance = numerator ./ denominator;
           distance_l = distance_l + distance;
        else
           xlo=0; xhi=nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           numerator = abs((xhi - xlo) * (ylo - res1(2,i)) - (xlo - res1(1,i)) * (yhi - ylo));
           % Find the denominator for our point-to-line distance formula.
	       denominator = sqrt((xhi - xlo) ^ 2 + (yhi - ylo) ^ 2);
	    
	       % Compute the distance.
	       distance = numerator ./ denominator;
           distance_l = distance_l + distance;
        end
    end
    total_distance = distance_l + distance_r;
    if(f_ind == 1)
        disp('------ RESULT ------');
        disp(['distance of points to epipolar lines on two images (sum) using camera parameter is :' num2str(total_distance)]);
    else
        disp(['distance of points to epipolar lines on two images (sum) using eight-point algorithm is :' num2str(total_distance)]);
    end
end
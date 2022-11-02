c1 = zeros(3,39);
c2 = zeros(3,39);
v1 = zeros(3,39);
v2 = zeros(3,39);
result= zeros(3,39);

for pix = 1:39
    trans = [[1 0 0 ; 0 1 0; 0 0 1;0 0 0] translation(:,4)];
    trans2 = [[1 0 0 ; 0 1 0; 0 0 1; 0 0 0] translation2(:,4)];
    c1(:,pix) = (-rotation(1:3,1:3).' * trans(1:3,4));
    c2(:,pix) = (-rotation2(1:3,1:3).' * trans2(1:3,4));
    v1(:,pix) = (rotation(1:3,1:3).'* inv(parameter1.Kmat) * temp3(:,pix));;
    v2(:,pix) = (rotation2(1:3,1:3).'* inv(parameter2.Kmat) * dtemp3(:,pix));
    v_vec = [v1(:,pix),-v2(:,pix)];
    v_vec = v_vec(1:2,1:2);
    lambda = inv(v_vec)*(c2(1:2,pix) - c1(1:2,pix));
    result(:,pix) = c1(:,pix) + v1(:,pix)*lambda(1);
end
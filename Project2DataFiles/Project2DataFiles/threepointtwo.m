reconstructed = zeros(3,39);


for pix = 1:39
    trans = inv(rotation) * translation;
    reconstructed(:,pix) = (-rotation(1:3,1:3).' * trans(1:3,4)) + (rotation(1:3,1:3).'* inv(parameter1.Kmat) * temp3(:,pix));
end


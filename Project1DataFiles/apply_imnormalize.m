%Normalization Function
function n = apply_imnormalize(x)

image = double(x);
n = image/255.0-0.5;

end
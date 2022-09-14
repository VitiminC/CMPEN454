%Normalization Function
function n = normalize(x)

image = double(x);
n = image/255.0-0.5;

end
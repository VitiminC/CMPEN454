%ReLu Function
function output = apply_relu(x)

image = double(x);
output = max(image,0);

end
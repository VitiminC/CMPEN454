%Normalization Function
function c = convolution(x,f)
output_shape = zeros(size(x,1),size(x,2),size(f,4));


c = imfilter(x,f,X);

end
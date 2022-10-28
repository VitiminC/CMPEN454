%Convolution Function
function output = apply_convolve(x,filter,bias)
x = double(x);
output = zeros(size(x,1),size(x,2),size(filter,4));

d2 = size(filter,4);

for i=1:d2
    %for k=1:d1
    temp_matrix = zeros(size(x));
    for j = 1:size(x,3)
        temp = imfilter(x(:,:,j),rot90(filter(:,:,j,i),2));
        temp_matrix(:,:,j) = temp;
    end
    temp_sum = sum(temp_matrix,3) + bias(i);
    output(:,:,i) = temp_sum;
end



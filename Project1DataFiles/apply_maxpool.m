%MaxPool Function
function output = apply_maxpool(x)

output = zeros(size(x,1)/2,size(x,2)/2,size(x,3));
x = double(x);
d1 = size(x,3);


for i=1:d1
    num_windows_x = size(x,1)/2;
    num_windows_y = size(x,2)/2;

    for j=1:num_windows_x
        for k = 1:num_windows_y
            output(j,k,i) = max(x(j*2-1:j*2,k*2-1:k*2,i),[],'all');
        end
    end
end

end

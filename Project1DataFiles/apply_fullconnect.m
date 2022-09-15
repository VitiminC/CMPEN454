%Fullyconnect Function
function output = apply_fullconnect(x,filter,bias)

x = double(x);
output = zeros(1,1,size(filter,4));

d2 = size(filter,4);

%for i=1:d2  
%    temp = imfilter(x,filter(:,:,:,i));
%    tempsum = sum(temp,"all");
%    output(:,:,i) = tempsum + bias(i);
%end

for i=1:d2
    %for k=1:d1
    temp_matrix = zeros(size(x));
    for j = 1:size(x,3)
    temp = imfilter(x(:,:,j),filter(:,:,j,i));
    temp_matrix(:,:,j) = temp;
    end
    temp_sum = sum(temp_matrix,'all');
    output(:,:,i) = temp_sum + bias(i);
end

end



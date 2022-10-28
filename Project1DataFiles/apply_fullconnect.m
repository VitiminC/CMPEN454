%Fullyconnect Function
function output = apply_fullconnect(x,filter,bias)

x = double(x);
output = zeros(1,1,size(filter,4));

d2 = size(filter,4);

for i=1:d2 % index filter
    sum = 0;
    for j = 1:size(x,3) % index channel
        for k = 1:size(x,2) % index column
            for z = 1:size(x,1) %index row
                sum = sum + x(z,k,j) * filter(z,k,j,i);
            end
        end
    end
    output(:,:,i) = sum + bias(i);
end

end



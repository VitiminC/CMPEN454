%SoftMax Function
function output = apply_softmax(x)
x = double(x);

alpha = max(x,[],"all");

output = (exp(x) - alpha)/sum((exp(x) - alpha),'all');

end


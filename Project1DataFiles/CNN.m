function c = CNN(img)

x1 = normalize(img);
x2 = convolution(x1,filterbanks(2));
x3 = relu(x2);
x4 = convolution(x3,filterbanks(4));
x5 = relu(x4);
x6 = maxpool(x5);
x7 = convolution(x6,filterbanks(7));
x8 = relu(x7);
x9 = convolution(x8,filterbanks(8));

c = x9;

end
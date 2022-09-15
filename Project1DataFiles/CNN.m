function c = CNN(img,filterbanks,biasvectors)

x1 = apply_imnormalize(img);
x2 = apply_convolve(x1,filterbanks{2},biasvectors{2});
x3 = apply_relu(x2);
x4 = apply_convolve(x3,filterbanks{4},biasvectors{4});
x5 = apply_relu(x4);
x6 = apply_maxpool(x5);
x7 = apply_convolve(x6,filterbanks{7},biasvectors{7});
x8 = apply_relu(x7);
x9 = apply_convolve(x8,filterbanks{9},biasvectors{9});
x10 = apply_relu(x9);
x11 = apply_maxpool(x10);
x12 = apply_convolve(x11,filterbanks{12},biasvectors{12});
x13 = apply_relu(x12);
x14 = apply_convolve(x13,filterbanks{14},biasvectors{14});
x15 = apply_relu(x14);
x16 = apply_maxpool(x15);
x17 = apply_fullconnect(x16,filterbanks{17},biasvectors{17});
x18 = apply_softmax(x17);

c = x18;

end
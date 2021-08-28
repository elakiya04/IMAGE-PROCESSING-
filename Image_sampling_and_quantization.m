%% Image Sampling
pout=imread("#Image path here");
pout=rgb2gray(pout);
imshow(pout);
title('original');
b=pout(1:2:end,:);
figure, imshow(b);
title('sampled half of x');
c= pout(:,1:2:end);
figure, imshow(c);
title('sampled half of y');
d=pout(1:2:end, 1:2:end);
figure, imshow(d);
title('sampled half of x and y');
e=pout(1:4:end,:);
figure, imshow(e);
title('sampled quarter of x');
f=pout(:,1:4:end);
figure, imshow(f);
title('sampled quarter of y');
g=pout(1:4:end,1:4:end);
figure, imshow(g);
title('sampled quarter of x and y');

%% Quantization
h=pout/2;
figure, imshow(h);
title('quantized half of current gray scale levels');
i=pout/4;
figure, imshow(i);
title('quantized quarter of current gray scale levels');

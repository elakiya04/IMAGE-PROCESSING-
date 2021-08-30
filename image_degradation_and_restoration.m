clc;
close all;
clear all;
 
%Reading an image
i=imread('INSERT IMAGE HERE');
a=rgb2gray(i);   % Coloured to Gray Conversion
a=im2double(a);
[X, Y]=size(a); % Size of input image
%Blurring an image
h_xy=fspecial('motion',20,45);
b=imfilter(a, h_xy, 'conv', 'circular');
 
% Defining the noise with zero mean and minimum variance
n_mean = 0;
n_var = 0.001;
g_xy = imnoise(b, 'gaussian', n_mean, n_var); % Addition of Noise to the blurred image
 
% Taking Fourier Transform of Blurred Image
G_uv=fft2(b);
G_uv=fftshift(G_uv);
 
% Taking Fourier Transform of Degraded Image
G1_uv=fft2(g_xy);
G1_uv=fftshift(G1_uv);
 
% Taking Fourier Transform of Filter
H_uv=fft2(h_xy, X, Y);
H_uv=fftshift(H_uv);
 
%Inverse filtering of blurred image
t=25;
o=zeros(X,Y); % Defining F^(u,v) equal to the size of original image
for u = 1:X
   for v = 1:Y
       if ((u-X/2)^2 + (v-Y/2)^2) <= t^2 % Distance from Cen to the Threshold Value
           % Applying Inverse Filtering Formula valid from cen to
           % threshold value radisu
           o(u,v) = G_uv(u,v)./H_uv(u,v); 
       end
   end
end
 
% Restored Image Display in Spatial Domain
o = ifftshift(o);
o = ifft2(o);
o = real(o);
 
%Inverse filtering of degraded image
t=25;
o1=zeros(X,Y); % Defining F^(u,v) equal to the size of original image
for u = 1:X
   for v = 1:Y
       if ((u-X/2)^2 + (v-Y/2)^2) <= t^2 % Distance from Cen to the Threshold Value
           % Applying Inverse Filtering Formula valid from cen to
           % threshold value radisu
           o1(u,v) = G1_uv(u,v)./H_uv(u,v); 
       end
   end
end
 
% Restored Image Display in Spatial Domain
o1 = ifftshift(o1);
o1 = ifft2(o1);
o1 = real(o1);
 
%Output images
subplot(421);
imshow(a,[]);
title('Input Image');
subplot(422);
imshow(b,[]);
title('Blurred Image');
subplot(423);
imshow(g_xy,[]);
title('Blurred Image with gaussian noise');
subplot(424);
imshow(log(abs(G_uv))+1,[]);
title('DFT of Blurred Image (G(u,v))');
subplot(425);
imshow(log(abs(G1_uv))+1,[]);
title('DFT of Blurred&Degraded Image (G1(u,v))');
subplot(426);
imshow(log(abs(H_uv))+1,[]);
title('DFT of Filter (H(u,v))');
subplot(427);
imshow(o,[]);
title(['Restored Blurred image,r = ',num2str(t)]);
subplot(428);
imshow(o1,[]);
title(['Restored Blurred&Degraded image,r = ',num2str(t)]);


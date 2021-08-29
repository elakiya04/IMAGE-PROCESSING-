clc; clear all; close all;
A = imread('#INSERT IMAGE HERE')
B= im2double(rgb2gray(A));
a = imresize(B,[256,256]);
figure(1),  imshow(a), title('original image')

f =fft2(a);
figure(2), subplot(1,2,1), imshow(f), title('fft using predefined function');

%kernel matrix initialization
[r A] = size(a)
x = zeros([r A]);

%kernel matrix

for M = 0:r-1
    for N = 0:A-1
         x(M+1,N+1) = exp((-i*2*pi*M*N)/r);
         
    end
end

x

%resultant dft matrix

r1 = x*a*x.'
mag=real(r1)
figure(2), subplot(1,2,2), imshow(mag), title('fft using code'); 

C=ifft2(f); 
figure(3), imshow(C), title("IFT"); 


%LAPLACIAN
%Input Image
A=imread('INSERT IMAGE HERE');
A=rgb2gray(A)
figure(); 
subplot(1,3,1);
imshow(A);
title('original image');

%Preallocate the matrices with zeros
I1=A;
I=zeros(size(A));
I2=zeros(size(A));

%Filter Masks
F1=[0 1 0;1 -4 1; 0 1 0];
F2=[1 1 1;1 -8 1; 1 1 1];

%Padarray with zeros
A=padarray(A,[1,1]);
A=double(A);

%Implementation of the equation for Laplacian Filter
for i=1:size(A,1)-2
    for j=1:size(A,2)-2
       
        I(i,j)=sum(sum(F1.*A(i:i+2,j:j+2)));
       
    end
end

I=uint8(I);
subplot(1,3,2);
imshow(I);title('Laplacian Filtered Image');

%Sharpenend Image
B=I1-I;
subplot(1,3,3);
imshow(B);title('Sharpened Image');


%image sharpening using unsharp mask
prompt = 'Size of the kernel (Size Should be odd): ';
x = input(prompt);
if mod(x,2)==0
    disp('Enter odd number')
    return
end

kernel = ones(x);

scale =1;

a = rgb2gray(imread('INSERT IMAGE HERE'));

subplot(1,4,1)
imshow(a)
title('ORIGINAL IMAGE')

[r,c] = size(a);
[R ,C] = size(kernel);

s = floor(R/2) ;

paddedmat = zeros([r+2*s,c+2*s]);

for i = 1:r
    for j=1:c
        paddedmat(i+s,j+s)=a(i,j);
    end
end

temp =0;
avg=0;

for i=1:R
    for j=1:C
        avg= avg+kernel(i,j);
    end
end

[r1 , c1] = size(paddedmat);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp = temp + paddedmat(i+k,j+m)*kernel(i,j);
            end
        end
        paddedmat(s+1+k,s+1+m)= temp/avg;
        temp=0;
    end
end

resultant = uint8(paddedmat(s+1:r+s,s+1:c+s));
subplot(1,4,2)
imshow(resultant)
title('AVERAGE FILTERED IMAGE');

res = scale*imsubtract(a,resultant);
subplot(1,4,3)
imshow(res)
title('IMAGE MASK');

sharp = imadd(a,res);
subplot(1,4,4)
imshow(sharp)
title('SHARPENED IMAGE');


% high boost filter
% scale factor = 2
a = imread('INSERT IMAGE HERE');
a=rgb2gray(a);
figure;
subplot(1,2,1);
imshow(a);
title('original image');

laplacianKernel = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
deltaFunction = [0, 0, 0; 0, 1, 0; 0, 0, 0];
scaleFactor = 2; %From 0 to +255, including fractional numbers like 0.5
kernel = laplacianKernel + scaleFactor * deltaFunction;
% Normalize so that the mean intensity doesn't change.
kernel = kernel / sum(kernel(:))
% Filter the image
filteredImage = imfilter(a, kernel);
subplot(1,2,2);
imshow(filteredImage);
title('filtered image, A = 2');

%% scale factor = 20
a = imread('INSERT IMAGE HERE');
figure;
subplot(1,2,1);
imshow(a);
title('original image');

laplacianKernel = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
deltaFunction = [0, 0, 0; 0, 1, 0; 0, 0, 0];
scaleFactor = 20; %From 0 to +255, including fractional numbers like 0.5
kernel = laplacianKernel + scaleFactor * deltaFunction;
% Normalize so that the mean intensity doesn't change.
kernel = kernel / sum(kernel(:))
% Filter the image
filteredImage = imfilter(a, kernel);
subplot(1,2,2);
imshow(filteredImage);
title('filtered image, A = 20');

%% scale factor = 5
a = imread('INSERT IMAGE HERE');
figure;
subplot(1,2,1);
imshow(a);
title('original image');

laplacianKernel = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
deltaFunction = [0, 0, 0; 0, 1, 0; 0, 0, 0];
scaleFactor = 5; %From 0 to +255, including fractional numbers like 0.5
kernel = laplacianKernel + scaleFactor * deltaFunction;
% Normalize so that the mean intensity doesn't change.
kernel = kernel / sum(kernel(:))
% Filter the image
filteredImage = imfilter(a, kernel);
subplot(1,2,2);
imshow(filteredImage);
title('filtered image, A = 5');

%% scale factor = 200
a = imread('INSERT IMAGE HERE');
figure;
subplot(1,2,1);
imshow(a);
title('original image');

laplacianKernel = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
deltaFunction = [0, 0, 0; 0, 1, 0; 0, 0, 0];
scaleFactor = 200; %From 0 to +255, including fractional numbers like 0.5
kernel = laplacianKernel + scaleFactor * deltaFunction;
% Normalize so that the mean intensity doesn't change.
kernel = kernel / sum(kernel(:))
% Filter the image
filteredImage = imfilter(a, kernel);
subplot(1,2,2);
imshow(filteredImage);
title('filtered image, A = 200');



%high_boost filtering
A=imread('INSERT IMAGE HERE');
A=rgb2gray(A);
%A=imnoise(A,'salt and pepper', 0.02);
figure(1)
subplot(1, 3, 1)
imshow(A);
title('ORIGINAL IMAGE');
[r,c]=size(A);
g=zeros([r, c]);
for x=2:r-2
        for y=2:c-2
        g(x,y)=A(x,y+1)+A(x,y-1)+A(x-1,y)+A(x+1,y)-4*A(x,y);
        %g(x,y)=-A(x,y+1)-A(x,y-1)-A(x-1,y)-A(x+1,y)+4*A(x,y);
        %g(x,y)=f(x-1,y-1)+f(x-1,y)+f(x-1,y+1)+f(x,y-1)-8*f(x,y)+f(x,y+1)+f(x+1,y-1)+f(x+1,y)+f(x+1,y+1);
       
    end;
end;
for x=2: r
    for y=2:c
d(x,y)=A(x,y)+g(x,y);
    end;
end;
figure(1)
subplot(1, 3, 2)
imshow(g);
title('Edge changed');  
figure(1)
subplot(1, 3, 3)
imshow(d)
title('Original + edge chnaged');

%HIGH BOOST
clc;
clear all;
close all;
prompt = 'Size of the kernel (Size Should be odd): ';
x = input(prompt);
if mod(x,2)==0
    disp('Enter odd number')
    return
end
kernel = ones(x);
disp = 'Boost factor =';
scale = input(disp);
a = rgb2gray(imread('handxray.jpeg'));
subplot(1,4,1)
imshow(a)
title('ORIGINAL IMAGE')
[r,c] = size(a);
[R ,C] = size(kernel);
s = floor(R/2) ;
paddedmat = zeros([r+2*s,c+2*s]);
for i = 1:r
    for j=1:c
        paddedmat(i+s,j+s)=a(i,j);
    end
end
temp =0;
avg=0;
for i=1:R
    for j=1:C
        avg= avg+kernel(i,j);
    end
end
[r1 , c1] = size(paddedmat);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp = temp + paddedmat(i+k,j+m)*kernel(i,j);
            end
        end
        paddedmat(s+1+k,s+1+m)= temp/avg;
        temp=0;
    end
end
resultant = uint8(paddedmat(s+1:r+s,s+1:c+s));
subplot(1,4,2)
imshow(resultant)
title('AVERAGE FILTERED IMAGE');
res = scale*imsubtract(a,resultant);
subplot(1,4,3)
imshow(res)
title('IMAGE MASK');
sharp = imadd(a,res);
subplot(1,4,4)
imshow(sharp)
title('SHARPENED IMAGE');

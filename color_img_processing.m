%RGB_SMOOTH
clc;
clear all;
close all;
img = imread("INSERT IMAGE HERE"); % input
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
a = zeros(size(img, 1), size(img, 2));
img_red = cat(3, red, a, a);
img_green = cat(3, a, green, a);
img_blue = cat(3, a, a, blue);

original_img_conversion = cat(3, red, green, blue);
figure(1)
imshow(img)
title('Original image')
figure(2)
subplot(221)
imshow(img_red)
title('Red channel')
subplot(222)
imshow(img_green)
title('Green channel')
subplot(223)
imshow(img_blue)
title('Blue channel')
subplot(224)
imshow(original_img_conversion)
title('Back to original image')

kernel = [ 0 1 0; 1 -4 1; 0 1 0];
% kernel = [ 1 1 1; 1 -8 1; 1 1 1];
%kernel = [ -1 0 0; -1 0 0; -1 0 0];

[r,c] = size(a);
[R ,C] = size(kernel);

s = floor(R/2) ;

paddedmat1 = zeros([r+2*s,c+2*s]);
paddedmat2 = zeros([r+2*s,c+2*s]);
paddedmat3 = zeros([r+2*s,c+2*s]);

for i = 1:r
    for j=1:c
        paddedmat1(i+s,j+s)= red(i,j);
        paddedmat2(i+s,j+s)= green(i,j);
        paddedmat3(i+s,j+s)= blue(i,j);
    end
end

temp1=0;
temp2=0;
temp3=0;

[r1 , c1] = size(paddedmat1);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp1 = temp1 + paddedmat1(i+k,j+m)*kernel(i,j);
                temp2 = temp2 + paddedmat2(i+k,j+m)*kernel(i,j);
                temp3 = temp3 + paddedmat3(i+k,j+m)*kernel(i,j);
            end
        end
        red_lap(1+k,1+m)= temp1;
        green_lap(1+k,1+m)= temp2;
        blue_lap(1+k,1+m)= temp3;
        temp1=0;
        temp2=0;
        temp3=0;
    end
end

red_lap = uint8(red_lap);
green_lap = uint8(green_lap);
blue_lap = uint8(blue_lap);

red_sharp = imsubtract(red,red_lap);
green_sharp = imsubtract(green,green_lap);
blue_sharp = imsubtract(blue,blue_lap);

img_red_sharp = cat(3, red_sharp, a, a);
img_green_sharp = cat(3, a, green_sharp, a);
img_blue_sharp = cat(3, a, a, blue_sharp);

figure(3)
subplot(2,2,1)
imshow(img_red_sharp)
title('RED filtered Image');
subplot(2,2,2)
imshow(img_green_sharp)
title('Green filtered Image');
subplot(2,2,3)
imshow(img_blue_sharp)
title('Blue filtered Image');

Sharpened_img = cat(3,red_sharp,green_sharp, blue_sharp);
subplot(2,2,4)
imshow(Sharpened_img)
title('Sharpened Image');

%RBG_SMOOTH 

img = imread('INSERT IMAGE HERE'); % input
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
a = zeros(size(img, 1), size(img, 2));
img_red = cat(3, red, a, a);
img_green = cat(3, a, green, a);
img_blue = cat(3, a, a, blue);

original_img_conversion = cat(3, red, green, blue);
figure(1)
imshow(img)
title('Original image')
figure(2)
subplot(221)
imshow(img_red)
title('Red channel')
subplot(222)
imshow(img_green)
title('Green channel')
subplot(223)
imshow(img_blue)
title('Blue channel')
subplot(224)
imshow(original_img_conversion)
title('Back to original image')

kernel = ones(7);
[r,c] = size(a);
[R ,C] = size(kernel);

s = floor(R/2) ;

paddedmat1 = zeros([r+2*s,c+2*s]);
paddedmat2 = zeros([r+2*s,c+2*s]);
paddedmat3 = zeros([r+2*s,c+2*s]);

for i = 1:r
    for j=1:c
        paddedmat1(i+s,j+s)= red(i,j);
        paddedmat2(i+s,j+s)= green(i,j);
        paddedmat3(i+s,j+s)= blue(i,j);
    end
end

temp1=0;
temp2=0;
temp3=0;
avg=0;

for i=1:R
    for j=1:C
        avg= avg+kernel(i,j);
    end
end

[r1 , c1] = size(paddedmat1);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp1 = temp1 + paddedmat1(i+k,j+m)*kernel(i,j);
                temp2 = temp2 + paddedmat2(i+k,j+m)*kernel(i,j);
                temp3 = temp3 + paddedmat3(i+k,j+m)*kernel(i,j);
            end
        end
        red(1+k,1+m)= temp1/avg;
        green(1+k,1+m)= temp2/avg;
        blue(1+k,1+m)= temp3/avg;
        temp1=0;
        temp2=0;
        temp3=0;
    end
end


img_red_filt = cat(3, red, a, a);
img_green_filt = cat(3, a, green, a);
img_blue_filt = cat(3, a, a, blue);

figure(3)
subplot(2,2,1)
imshow(img_red_filt)
title('RED filtered Image');
subplot(2,2,2)
imshow(img_green_filt)
title('Green filtered Image');
subplot(2,2,3)
imshow(img_blue_filt)
title('Blue filtered Image');

filt_img = cat(3,red,green, blue);
subplot(2,2,4)
imshow(filt_img)
title('filtered Image');

%CMY_SHARP
clc;
clear all;
close all;
img = imread('INSERT IMAGE HERE'); % Read image
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
figure, imshow(img), title('Original image')

figure,
C1=255-red;
M=255-green;
Y=255-blue;

cmy = cat(3,C1,M,Y);
figure(2)
subplot(221)
imshow(C1)
title('C')
subplot(222)
imshow(M)
title('M')
subplot(223)
imshow(Y)
title('Y')
subplot(224)
imshow(cmy)
title('CMY IMAGE')

% kernel = [ 0 1 0; 1 -4 1; 0 1 0];
kernel = [ 1 1 1; 1 -8 1; 1 1 1];
[r,c] = size(C1);
[R ,C] = size(kernel);

s = floor(R/2) ;

paddedmat1 = zeros([r+2*s,c+2*s]);
paddedmat2 = zeros([r+2*s,c+2*s]);
paddedmat3 = zeros([r+2*s,c+2*s]);

for i = 1:r
    for j=1:c
	    paddedmat1(i+s,j+s)= C1(i,j);
        paddedmat2(i+s,j+s)= M(i,j);
        paddedmat3(i+s,j+s)= Y(i,j);
    end
end
temp1=0;
temp2=0;
temp3=0;

[r1 , c1] = size(paddedmat1);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp1 = temp1 + paddedmat1(i+k,j+m)*kernel(i,j);
                temp2 = temp2 + paddedmat2(i+k,j+m)*kernel(i,j);
                temp3 = temp3 + paddedmat3(i+k,j+m)*kernel(i,j);
            end
        end
        C_lap(1+k,1+m)= temp1;
        M_lap(1+k,1+m)= temp2;
        Y_lap(1+k,1+m)= temp3;
        temp1=0;
        temp2=0;
        temp3=0;
    end
end

C_lap = uint8(C_lap);
M_lap = uint8(M_lap);
Y_lap = uint8(Y_lap);


C_sharp = imsubtract(C1,C_lap);
M_sharp = imsubtract(M,M_lap);
Y_sharp = imsubtract(Y,Y_lap);

figure(3)
subplot(2,2,1)
imshow(C_sharp)
title('C');
subplot(2,2,2)
imshow(M_sharp)
title('M');
subplot(2,2,3)
imshow(Y_sharp)
title('Y');

Sharpened_img = cat(3,C_sharp,M_sharp, Y_sharp);
subplot(2,2,4)
imshow(Sharpened_img)
title('Sharpened Image');

%CMY_SMOOTH
clc;
clear all;
close all;
img = imread('INSERT IMAGE HERE'); % Read image
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
figure, imshow(img), title('Original image')

figure,
C1=255-red;
M=255-green;
Y=255-blue;

cmy = cat(3,C1,M,Y);
figure(2)
subplot(221)
imshow(C1)
title('C')
subplot(222)
imshow(M)
title('M')
subplot(223)
imshow(Y)
title('Y')
subplot(224)
imshow(cmy)
title('CMY IMAGE')

kernel = ones(7);
[r,c] = size(C1);
[R ,C] = size(kernel);

s = floor(R/2) ;

paddedmat1 = zeros([r+2*s,c+2*s]);
paddedmat2 = zeros([r+2*s,c+2*s]);
paddedmat3 = zeros([r+2*s,c+2*s]);

for i = 1:r
    for j=1:c
	    paddedmat1(i+s,j+s)= C1(i,j);
        paddedmat2(i+s,j+s)= M(i,j);
        paddedmat3(i+s,j+s)= Y(i,j);
    end
end

temp1=0;
temp2=0;
temp3=0;
avg=0;

for i=1:R
    for j=1:C
        avg= avg+kernel(i,j);
    end
end

[r1 , c1] = size(paddedmat1);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp1 = temp1 + paddedmat1(i+k,j+m)*kernel(i,j);
                temp2 = temp2 + paddedmat2(i+k,j+m)*kernel(i,j);
                temp3 = temp3 + paddedmat3(i+k,j+m)*kernel(i,j);
            end
        end
        C1(1+k,1+m)= temp1/avg;
        M(1+k,1+m)= temp2/avg;
        Y(1+k,1+m)= temp3/avg;
        temp1=0;
        temp2=0;
        temp3=0;
    end
end

figure(3)
subplot(2,2,1)
imshow(C1)
title('C');
subplot(2,2,2)
imshow(M)
title('M');
subplot(2,2,3)
imshow(Y)
title('Y');

filt_img = cat(3,C1,M, Y);
subplot(2,2,4)
imshow(filt_img)
title('Smoothened Image');

%HSI_SHARP 
clc;
clear all;
close all;

A=imread("INSERT IMAGE HERE");
figure(1),imshow(A);title('RGB Image');
%Represent the RGB image in [0 1] range
I=double(A)/255;

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%Hue
numi=1/2*((R-G)+(R-B));
denom=((R-G).^2+((R-B).*(G-B))).^0.5;

%To avoid divide by zero exception add a small number in the denominator
H=acosd(numi./(denom+0.000001));

%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);

%Normalize to the range [0 1]
H=H/360;

%Saturation
S=1 - (3./(sum(I,3)+0.000001)).*min(I,[],3);


%Intensity
I=sum(I,3)./3;


%HSI
HSI=zeros(size(A));
HSI(:,:,1)=H;
HSI(:,:,2)=S;
HSI(:,:,3)=I;

figure(2),subplot(2,2,1);imshow(H),title('H Image')
figure(2),subplot(2,2,2);imshow(S),title('S Image')
figure(2),subplot(2,2,3);imshow(I),title('I Image')


figure(2),subplot(2,2,4);imshow(HSI);title('HSI Image');

kernel = [ 0 1 0; 1 -4 1; 0 1 0];
%kernel = [ 1 1 1; 1 -8 1; 1 1 1];
%kernel = [ -1 0 0; -1 0 0; -1 0 0];

[r,c] = size(H);
[R ,C] = size(kernel);

s = floor(R/2) ;

paddedmat1 = zeros([r+2*s,c+2*s]);
paddedmat2 = zeros([r+2*s,c+2*s]);
paddedmat3 = zeros([r+2*s,c+2*s]);

for i = 1:r
    for j=1:c
        paddedmat1(i+s,j+s)= H(i,j);
        paddedmat2(i+s,j+s)= S(i,j);
        paddedmat3(i+s,j+s)= I(i,j);
    end
end

temp1=0;
temp2=0;
temp3=0;

[r1 , c1] = size(paddedmat1);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp1 = temp1 + paddedmat1(i+k,j+m)*kernel(i,j);
                temp2 = temp2 + paddedmat2(i+k,j+m)*kernel(i,j);
                temp3 = temp3 + paddedmat3(i+k,j+m)*kernel(i,j);
            end
        end
        H_lap(1+k,1+m)= temp1;
        G_lap(1+k,1+m)= temp2;
        B_lap(1+k,1+m)= temp3;
        temp1=0;
        temp2=0;
        temp3=0;
    end
end

H_sharp = imsubtract(H,H_lap);
S_sharp = imsubtract(G,G_lap);
I_sharp = imsubtract(B,B_lap);

figure(3)
subplot(2,2,1)
imshow(H_sharp)
title('H');
subplot(2,2,2)
imshow(S_sharp)
title('S');
subplot(2,2,3)
imshow(I_sharp)
title('I');

Sharpened_img = cat(3,H_sharp,S_sharp, I_sharp);
subplot(2,2,4)
imshow(Sharpened_img)
title('Sharpened Image');

%HSI SMOOTH
clc;
clear all;
close all;

A=imread('colorultrasound.jpeg');
figure(1),imshow(A);title('RGB Image');
%Represent the RGB image in [0 1] range
I=double(A)/255;

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%Hue
numi=1/2*((R-G)+(R-B));
denom=((R-G).^2+((R-B).*(G-B))).^0.5;

%To avoid divide by zero exception add a small number in the denominator
H=acosd(numi./(denom+0.000001));

%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);

%Normalize to the range [0 1]
H=H/360;

%Saturation
S=1 - (3./(sum(I,3)+0.000001)).*min(I,[],3);


%Intensity
I=sum(I,3)./3;


%HSI
HSI=zeros(size(A));
HSI(:,:,1)=H;
HSI(:,:,2)=S;
HSI(:,:,3)=I;

figure(2),subplot(2,2,1);imshow(H),title('H Image')
figure(2),subplot(2,2,2);imshow(S),title('S Image')
figure(2),subplot(2,2,3);imshow(I),title('I Image')


figure(2),subplot(2,2,4);imshow(HSI);title('HSI Image');

kernel = ones(7);
[r,c] = size(H);
[R ,C] = size(kernel);

s = floor(R/2) ;

paddedmat1 = zeros([r+2*s,c+2*s]);
paddedmat2 = zeros([r+2*s,c+2*s]);
paddedmat3 = zeros([r+2*s,c+2*s]);

for i = 1:r
    for j=1:c
        paddedmat1(i+s,j+s)= H(i,j);
        paddedmat2(i+s,j+s)= S(i,j);
        paddedmat3(i+s,j+s)= I(i,j);
    end
end

temp1=0;
temp2=0;
temp3=0;
avg=0;

for i=1:R
    for j=1:C
        avg= avg+kernel(i,j);
    end
end

[r1 , c1] = size(paddedmat1);
for k=0:r1-R
    for m=0:c1-C
        for i=1:R
            for j=1:C
                temp1 = temp1 + paddedmat1(i+k,j+m)*kernel(i,j);
                temp2 = temp2 + paddedmat2(i+k,j+m)*kernel(i,j);
                temp3 = temp3 + paddedmat3(i+k,j+m)*kernel(i,j);
            end
        end
        H(1+k,1+m)= temp1/avg;
        S(1+k,1+m)= temp2/avg;
        I(1+k,1+m)= temp3/avg;
        temp1=0;
        temp2=0;
        temp3=0;
    end
end


% img_red_filt = cat(3, red, a, a);
% img_green_filt = cat(3, a, green, a);
% img_blue_filt = cat(3, a, a, blue);

figure(3)
subplot(2,2,1)
imshow(H)
title('H');
subplot(2,2,2)
imshow(S)
title('S');
subplot(2,2,3)
imshow(I)
title('I');

filt_img = cat(3,H,S, I);
subplot(2,2,4)
imshow(filt_img)
title('Smoothened Image');



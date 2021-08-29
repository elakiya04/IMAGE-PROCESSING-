
%%%AVERAGE IMAGE
p=imread('inseert image here');
a=rgb2gray(p);
figure;
subplot(1,2,1);
imshow(a);
title('Original image');
[x,y]=size(p);
%[H, f1, f2]=freqz2(a);
%figure();
%mesh(real(H));
%title('Original image freq resp');
[x,y]=size(a);
for i = 2:x-1
    for j = 2:y-1
        sum = 0;
        sum=int32(sum);
        for m = i-1:i+1  
            for n = j-1:j+1
                tmp=a(m,n);
                tmp=int32(tmp);
                sum = sum + tmp;
                sum=int32(sum);
            end
        end
        b(i,j) = ceil(sum/9);
    end
end
subplot(1,2,2);
imshow(uint8(b));
title('AVERAGE IMAGE');

%freq resp
[H,f1,f2] = freqz2(b, [x, y]); 
figure();
mesh(real(H))
title("FREQUENCY RESPONSE")
%SNR
b=imresize(b, [x, y]);
snr=psnr(uint8(b), uint8(a))

%%%MAX FILTERED IMAGE
I1 = imread('insert image here');
L=rgb2gray(I1)
L= imnoise(L, 'salt & pepper', 0.02);
[r c] = size(L);
Rep = zeros(r + 2, c + 2);
for x = 2 : r + 1
    for y = 2 : c + 1
        Rep(x,y) = L(x - 1, y - 1);
    end
end
B = zeros(r, c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : 3
            for j = 1 : 3
                q = x - 1;     w = y -1;
                array((i - 1) * 3 + j) = Rep(i + q, j + w);
            end
        end
        B(x, y) = max(array(:));
    end
end
figure;
subplot(121);
imshow(L);
title('Original image');
subplot(122);
imshow(uint8(B));
title('MAX FILTERED IMAGE');



%%%MEDIAN FILTER
I1 = imread('insert image here');
I2=rgb2gray(I1);
L = imnoise(I2, 'salt & pepper', 0.02);
[r c] = size(L);
Rep = zeros(r + 2, c + 2);
for x = 2 : r + 1
    for y = 2 : c + 1
        Rep(x,y) = L(x - 1, y - 1);
    end
end
B = zeros(r, c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : 3
            for j = 1 : 3
                q = x - 1;     w = y -1;
                array((i - 1) * 3 + j) = Rep(i + q, j + w);
            end
        end
        B(x, y) = median(array(:));
    end
end


figure(2);
subplot(1, 3, 1);
imshow(I2);
title('Original image');
subplot(1, 3, 2);
imshow(L);
title('salt and pepper noise');
subplot(1, 3, 3);
imshow(uint8(B));
title('MEDIAN FILTER');


I1 = imread('insert image here');
L=rgb2gray(I1);
L = imnoise(I2, 'salt & pepper', 0.02);
[r c] = size(L);
Rep = zeros(r + 2, c + 2);
for x = 2 : r + 1
    for y = 2 : c + 1
        Rep(x,y) = L(x - 1, y - 1);
    end
end
B = zeros(r, c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : 3
            for j = 1 : 3
                q = x - 1;     w = y -1;
                array((i - 1) * 3 + j) = Rep(i + q, j + w);
            end
        end
        B(x, y) = min(array(:));
    end
end
figure;
subplot(121);
imshow(L);
title('with salt and pepper noise');
subplot(122);
imshow(uint8(B));
title('Min filtered image');

x=rand(size(a));
a(x(:)>0.95)=255;
subplot(2,3,2)
imshow(a)
title('IMAGE WITH SALT NOISE')

x=rand(size(a1));
a1(x(:)<0.1)=0;
subplot(2,3,3)
imshow(a1)
title('IMAGE WITH PEPPER NOISE')


%weighted avg
B=imread('ankle.jpg');
A= rgb2gray(B);
a = imnoise(A,'salt & pepper'); %addition of noise to check filter
figure;
subplot(121)
imshow(a)
title('ORIGINAL IMAGE WITH SALT AND PEPPER NOISE'); 
a=double(a);
h2=(1/16).*[1 2 1;2 4 2;1 2 1]; %weighted averaging filter mask
for i=1:size(a,1)-2 
    for j=1:size(a,2)-2
        b2(i,j)=sum(sum(h2.a(i:i+2,j:j+2))); %convolution of mask with image
end
end
subplot(122)
imshow(uint8(b2));
title('OUTPUT OF WEIGHTED AVERAGE FILTER');

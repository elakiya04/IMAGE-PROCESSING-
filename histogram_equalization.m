%using built-in fn 
i=imread('insert image here');
i=rgb2gray(i);
figure;
subplot(1,2,1);
imshow(i);
title('original image');
subplot(1,2,2);
a=imhist(i); 
imshow(a);
title('histogram');
imh=imadjust(i,[0.3,0.6],[0.0,1.0]);
imh1=histeq(i);
figure;
subplot(2,2,1);
imshow(imh);
title('streched');
subplot(2,2,2);
imhist(imh);
subplot(2,2,3);
imshow(imh1);
title('histogram eqalization');
subplot(2,2,4);
imhist(imh1);

%without using in-built function
a = rgb2gray(imread('insert image here'));
figure;
imshow(a)
title('input image')
 
[r,c] = size(a);
 
noflvl= 256; %no of gray levels
ref=[];
temp=0;
pk = zeros([noflvl 1]); %probablity of occurrence
cdf =zeros([noflvl 1]); %cummulative density function
pdf =zeros([noflvl 1]); %probablity density function
gry =zeros([noflvl 1]); %equation for gray shade
res =uint8(zeros([r,c])); %resultant matrix
 
for i =0:noflvl-1
    ref(i+1,1)=i;
end
 
for i = 1:noflvl
    for j = 1:r
        for k=1:c
            if ref(i,1)== a(j,k)
                pk(i,1) = pk(i,1)+1;
            end
        end
    end
    temp=temp+pk(i,1);
    cdf(i,1)= temp;
    pdf(i,1)=(temp/(r*c))*(noflvl-1);
    gry(i,1)=round(pdf(i,1));
end
 
%corrected histogram
 
for j=1:r
    for k=1:c
        for i=1:noflvl
            if a(j,k)== ref(i,1)
                res(j,k)=gry(i,1);
            end
        end
    end
end
 
%display(res)
 
figure;
subplot(1,2,1)
imshow(res)
title('histogram stretching-algorithm')
 
j =histeq(a);
subplot(1,2,2)
imshow(j)
title('histogram stretching built-in fn')

K=imhist(a)
figure;
imshow(K)
subplot(1,2,1)

title('histogram plot of original image')
 
subplot(1,2,2)
imhist(res);
title('histogram stretched plot')

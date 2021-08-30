%DEFINING STRUCTURING ELEMENT
clc;
clear all;
close all;
C=ones(5,5)
%C=[0, 1, 0; 1, 1, 1; 0, 1, 0];  %cross structure
%C=ones(1, 10) %vector
%C=[0, 0, 0, 1, 0, 0, 0; 0, 0, 1, 1, 1, 0, 0; 0, 1, 1, 1, 1, 1, 0; 0, 0, 1, 1, 1, 0, 0; 0, 0, 0, 1, 0, 0, 0;] %DIAMOND 

%MATLAB code for dilation,erosion,opening and closing of image
f1=rgb2gray(imread('INSERT IMAGE HERE'));
f=f1(:,:,1);
subplot(1,3,1);
imshow(uint8(f));
title('Original image');
[x,y]=size(f);
p=zeros(x,y);p2=zeros(x,y);p12=zeros(x,y);p13=zeros(x,y);
%Dilation
for s=2:x-2
    for t=2:y-2
        w1=[f(s-1,t-1)*C(1) f(s-1,t)*C(2) f(s-1,t+1)*C(3) f(s,t-1)*C(4) f(s,t)*C(5) f(s,t+1)*C(6) f(s+1,t-1)*C(7) f(s+1,t)*C(8) f(s+1,t+1)*C(9)];
        p(s,t)=max(w1);
    end
end
subplot(1,3,2);
imshow(uint8(p));
title('Dilated image');
%erosion
for s=2:x-1
    for t=2:y-1
        w12=[f(s-1,t-1)*C(1) f(s-1,t)*C(2) f(s-1,t+1)*C(3) f(s,t-1)*C(4) f(s,t)*C(5) f(s,t+1)*C(6) f(s+1,t-1)*C(7) f(s+1,t)*C(8) f(s+1,t+1)*C(9)];
        p1(s,t)=min(w12);
    end
end
subplot(1,3,3);
imshow(uint8(p1));
title('Eroded image');


%USING BUILT IN FUNCTION
E=rgb2gray(imread("INSERT IMAGE HERE"));
strel = C
F=imerode(E, strel);
G=imdilate(E, strel);
figure(1), subplot(1, 3, 1), imshow(E), title("OG IMG"); 
figure(1), subplot(1, 3, 2), imshow(F), title("ERDODED IMG")
figure(1), subplot(1, 3, 3), imshow(G), title("DIL IMG")

%OPENING:
clc;
clear all;
close all;
warning off;
a=rgb2gray(imread("INSERT IMAGE HERE"));
figure(1), subplot(131);
imshow(a);
title('Original Image');
w = ones(3);
[r,c] = size(a);
[R ,C] = size(w);
s = floor(R/2) ;
ref = R*C;
paddedmat = zeros([r+2*s,c+2*s]);
for i = 1:r
 for j=1:c
  paddedmat(i+s,j+s)=a(i,j);
 end
end
temp =0;
[r1 , c1] = size(paddedmat);
for k=0:r1-R
 for m=0:c1-C
 for i=1:R
 for j=1:C
 temp = temp + paddedmat(i+k,j+m)*w(i,j);
 end
 end
 if temp==ref
 output(s+1+k,s+1+m)= 1;
 else
 output(s+1+k,s+1+m)= 0;
 end
 temp=0;
 end
end
paddedmat1 = zeros([r+2*s,c+2*s]);
for i = 1:r
 for j=1:c
 paddedmat1(i+s,j+s)=output(i,j);
 end
end
for k=0:r1-R
 for m=0:c1-C
 for i=1:R
 for j=1:C
 temp = temp + paddedmat1(i+k,j+m)*w(i,j);
 end
 end
 if temp > 0
 output1(s+1+k,s+1+m)= 1;
 else
 output1(s+1+k,s+1+m)= 0;
 end
 temp=0;
 end
end
figure(1);
subplot(132);
imshow(output);
title('A(-)B');
subplot(133);
imshow(output1);
title('[A(-)B](+)B');

%CLOSING:
clc;
clear all;
close all;
warning off;
b=rgb2gray(imread('INSERT IMAGE HERE'));
a=imbinarize(b);
figure(1);
subplot(221);
imshow(b);
title('Original Image');
subplot(222);
imshow(a);
title('Binarized Image');
w = ones(3);
[r,c] = size(a);
[R ,C] = size(w);
s = floor(R/2) ;
ref = R*C;
paddedmat = zeros([r+2*s,c+2*s]);
for i = 1:r
 for j=1:c
 paddedmat(i+s,j+s)=a(i,j);
 end
end
temp =0;
[r1 , c1] = size(paddedmat);
for k=0:r1-R
 for m=0:c1-C
 for i=1:R
 for j=1:C
 temp = temp + paddedmat(i+k,j+m)*w(i,j);
 end
 end
 if temp >0
 output(s+1+k,s+1+m)= 1;
 else
 output(s+1+k,s+1+m)= 0;
 end
 temp=0;
 end
end
paddedmat1 = zeros([r+2*s,c+2*s]);
for i = 1:r
 for j=1:c
 paddedmat1(i+s,j+s)=output(i,j);
 end
end
for k=0:r1-R
 for m=0:c1-C
 for i=1:R
 for j=1:C
 temp = temp + paddedmat1(i+k,j+m)*w(i,j);
 end
 end
 if temp == ref
 output1(s+1+k,s+1+m)= 1;
 else
 output1(s+1+k,s+1+m)= 0;
 end
 temp=0;
 end
end
subplot(223);
imshow(output);
title('A(+)B');
subplot(224);
imshow(output1);
title('[A(+)B](-)B');

close all
clear
clc
%% input the image
a=imread('insert image here');
figure, imshow(a), title("Original Image")
a=imresize(a,[256,256]);
b= rgb2ycbcr(a);
figure, imshow(b), title("YCbCr Image")
%% No. of coefficient
cf=2;
%% sampling
cb=b(1:cf:end,1:cf:end,2);
cr=b(1:cf:end,1:cf:end,3);
 
[k1,k2]=size(cb);
for i=cf:cf:cf*k1
    for j=cf:cf:cf*k2
        cbx(i-cf+1:i,j-cf+1:j)=cb(i/cf,j/cf);
        crx(i-cf+1:i,j-cf+1:j)=cr(i/cf,j/cf);
    end
end
 
b(:,:,2)=cbx;
b(:,:,3)=crx;
 Y=b(:,:,1);
%% luminance compression
bb=zeros(size(Y));
kk=1;
sizeblock=8;
k=[1 :sizeblock];
qz=8;cf=3;
kkk=1;
for i=1:(size(Y,1)/sizeblock)
    for j=1:(size(Y,2)/sizeblock)
        
     xx=Y(k +(i-1)*sizeblock, k+(j-1)*sizeblock);
     yy=dct2(xx);
     
     xy=yy;
     for ii=1:sizeblock
              for jj=1:sizeblock
     if (ii+jj)>cf
       yy(ii,jj)=0;
       yy2=yy;
     end
              end
     end
     
     
   
    
     yy=idct2(yy2);
     
    yc(k +(i-1)*sizeblock, k+(j-1)*sizeblock)=yy;
     kk=kk+1;
    end
end
 
b(:,:,1)=yc;
c= ycbcr2rgb(b);
figure, imshow(c), title("Compressed Image")
[kk1,kk2,kk3]=size(a);
CR=(1-(.5*kk1*kk2+kk1*kk2*cf/64)/(kk1*kk2*kk3))*100;
snrr(a,c)

%

function r = snrr(in, est)
% To find SNR between input (in) and estimate (est) in decibels (dB).
%
% Reference: Vetterli & Kovacevic, "Wavelets and Subband Coding", p. 372
error = in - est;
% r = 10 * log10(var(in(:), 1) / mean(error(:).^2));
r = 10 * log10((255^2)/ mean(error(:).^2));
end


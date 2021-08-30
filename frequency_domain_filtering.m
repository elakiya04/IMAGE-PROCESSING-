clc;
clear all;
close all;

%LOWPASS FILTER 
a=imread('INSERT IMAGE HERE');
a=rgb2gray(a);
[m,n]=size(a);
x=round(m/2); y=round(m/2);
f=fftshift(fft2(a));
c=60; 
%c=20; 

for u=1:m
    for v=1:n
        d(u,v)=sqrt((u-x).^2 + (v-y).^2);
        if d(u,v)<=c
            h(u,v)=1;
        else
            h(u,v)=0;
        end
    end
end
figure();imshow(a); title("ORIGINAL IMAGE");
figure(); mesh(h); title("Frequency Response");

e=(f.*h); g=ifft2(e); 
subplot(133); imshow(abs(g), []); title("FILTERED IMAGE");

%HIGHPASS FILTER 
a=imread('INSERT IMAGE HERE');
a=rgb2gray(a);
[m,n]=size(a);
x=round(m/2); y=round(m/2);
f=fftshift(fft2(a));
c=5; 
%c=20;
for u=1:m 
    for v=1:n
        d(u,v)=sqrt((u-x).^2 + (v-y).^2);
        if d(u,v)<=c
            h(u,v)=0;
        else
            h(u,v)=1;
        end
    end
end
figure(); 
imshow(a); title("ORIGINAL IMAGE");
figure(); mesh(h); title("Frequency Response");
e=f.*h; g=ifft2(e); 
subplot(133); imshow(abs(g), []); title("FILTERED IMAGE");




%BUTTERWORTH LOW PASS FILTER
a=imread('INSERT IMAGE HERE');
a=rgb2gray(a);
[m,n]=size(a);
N=1;
x=round(m/2); y=round(m/2);
f=fftshift(fft2(a));
%c=5; 
c=60;
for u=1:m 
    for v=1:n
        d(u,v)=sqrt((u-x).^2+(v-y).^2);
        h(u,v)=1/(1+(d(u,v)/c).^2*N);
    end
end

figure(1); imshow(a); title("ORIGINAL IMAGE");
figure(2); mesh(h); title("Frequency Response");
e=f.*h; g=ifft2(e); 
figure(3); imshow(abs(g), []); title("FILTERED IMAGE");


%BUTTERWORTH HIGH PASS FILTER
a=imread('INSERT IMAGE HERE');
a=rgb2gray(a);
[m,n]=size(a);
N=1;
x=round(m/2); y=round(m/2);
f=fftshift(fft2(a));
%c=5; 
c=60;
for u=1:m 
    for v=1:n
        d(u,v)=sqrt((u-x).^2+(v-y).^2);
        h(u,v)=1/(1+(c/d(u,v)).^2);
    end
end

figure(1); imshow(a); title("ORIGINAL IMAGE");
figure(2); mesh(h); title("Frequency Response");





%GAUSSIAN LOWPASS FILTER
a=imread('INSERT IMAGE HERE'); 
a=rgb2gray(a);
[m,n]=size(a); x=round(m/2); y=round(n/2);
f=fftshift(fft2(a)); % FOURIER TRANSFORM AND SHIFT
c=60;
for u=1:m 
    for v=1:n
        d(u,v)=sqrt((u-x).^2+(v-y).^2); % TRANSFER FUNCTION FOR GAUSSIAN LPF
        h(u,v)=exp(- (d(u,v))^2/(2*(c)^2)); 
    end
end
figure(); imshow(a); title("ORIGINAL IMAGE");
figure(); mesh(h); title("Frequency Response; c=60");
e=f.*h; g=ifft2(e); 
figure(); imshow(abs(g), []); title("FILTERED IMAGE; c=60");

%GAUSSIAN HIGH PASS FILTER
b=imread('INSERT IMAGE HERE'); 
b=rgb2gray(b);
[m,n]=size(b); 
x=round(m/2); y=round(m/2);
f=fftshift(fft2(b));
c=60;
for u=1:m 
    for v=1:n
        d(u,v)=sqrt((u-x).^2+(v-y).^2);
        h(u,v)=1-(exp(-d(u,v))^2/2*(c)^2);
    end
end
figure(1); imshow(b); title("ORIGINAL IMAGE");
figure(2); mesh(h); title("Frequency Response; c=60");
e=f.*h; g=ifft2(e); 
figure(3); imshow(abs(g), []); title("FILTERED IMAGE; c=60");

%Image negative 
J = imread("insert image here"); 
J=rgb2gray(J);
figure(1)
subplot(1,2,1)
imshow(J)
title("Original Image")
 
d(:,:,1) = 255 - J(:,:,1);
figure(1)
subplot(1,2,2)
imshow(d)
title("Image Negative")

%Log transformation
B = imread('insert image here');
B=rgb2gray(B);
figure(2)
subplot(1,2,1)
imshow(B)
title('Original Image');
K = double(B)/255; 
C = 3*log(1 + (K));
figure(2)
subplot(1,2,2)
imshow((C))
title('Log Transformation Image');

%POWER LAW TRANSFORMATION
E= imread('insert image here');
f=rgb2gray(E);
figure(3)
subplot(1,3,1)
imshow(f);
title('ORIGINAL IMAGE');
%POWER LAW TRANSFORMATION
F = im2double(f);
[m,n]=size(F);
%FOR GAMMA GREATER THAN 1
g=1.5;
for i=1:m
    for j=1:n
s(i,j)=1*(F(i,j).^g);
    end
end
figure(3)
subplot(1,3,2)
imshow(s);
title('Gamma greater than 1');
%FOR GAMMA LESSER THAN 1
g=0.5;
for i=1:m
    for j=1:n
h(i,j)=1*(F(i,j).^g);
    end
end
figure(3)
subplot(1,3,3)
imshow(h);
title('Gamma lesser than 1');
%PLOT FOR VARIOUS RANGES OF GAMMA
GRng=[0.04; 0.10; 0.20; 0.40; 0.67; 1; 1.5; 2.5; 5.0; 10.0; 25.0];
R=0:255;
C=1;
for i = 1 : 11
X=C*(R.^GRng(i));
Temp=256/X(256);
s=Temp*X;
figure(4)
subplot(1, 1, 1)
plot(R,s);
title('Plot Equation S = Cr^\gamma');
xlabel('Input Intensity Level,r');
ylabel('Output Intensity Level,s');
text(R(175),s(175),['\gamma = ',num2str(GRng(i))]);
hold all
axis([0 255 0 255]);
end

%CONTRAST STRETCHING
itemp = imread('insert image here');
i = itemp(:,:,1);
rtemp = min(i);         
rmin = min(rtemp);      
rtemp = max(i);         
rmax = max(rtemp);      
m = 255/(rmax - rmin);  
c = 255 - m*rmax;       
i_new = m*i + c;        
figure(5),subplot(1,2,1), imshow(i), title("original image");       
figure(5),subplot(1,2,2),imshow(i_new), title("contrast stretched image");   

%BIT PLANE SLICING
G=imread('insert image here');
figure(6), subplot(1,3,1), imshow(G), title("Original Image")
G = rgb2gray(G);
H=bitget(G,1); figure(6), subplot(1,3,2), imshow(logical(H));title('Bit plane 1');
H=bitget(G,2); figure(6), subplot(1,3,3), imshow(logical(H));title('Bit plane 2');
H=bitget(G,3); figure(7), subplot(1,3,1), imshow(logical(H));title('Bit plane 3');
H=bitget(G,4); figure(7), subplot(1,3,2), imshow(logical(H));title('Bit plane 4');
H=bitget(G,5); figure(7), subplot(1,3,3), imshow(logical(H));title('Bit plane 5');
H=bitget(G,6); figure(8), subplot(1,3,1), imshow(logical(H));title('Bit plane 6');
H=bitget(G,7); figure(8), subplot(1,3,2), imshow(logical(H));title('Bit plane 7');
H=bitget(G,8); figure(8), subplot(1,3,3), imshow(logical(H));title('Bit plane 8');

%GRAY LEVEL SLICING
p=imread('insert image here'); 
p=rgb2gray(p);
z=double(p);
[row,col]=size(z);
for i=1:1:row
    for j=1:1:col
        if((z(i,j)>=9)) && (z(i,j)<26)
    z(i,j)=255;
        else
    z(i,j)=p(i,j);
        end
    end
end
figure(9)
subplot(1,2,1)
imshow(p);
title('Original Image')
z=uint8(z);
figure(9)
subplot(1,2,2)
imshow(z);
title('Gray Level Slicing With Background');


%POINT DETECTION
j=rgb2gray(imread("INSERT IMAGE HERE"));
A=j(:, :, 1);
figure(1), subplot(1, 2, 1), imshow(A), title("original image"); 
I=zeros(size(A));
%Filter masks whe diagnols are considered. 
I=uint8(A);
F3=[-1 -1 -1; -1 8 -1; -1 -1 -1]; 
A=double(A); 
for i=1:size(A,1)-2
    for j=1:size(A, 2)-2
        I(i,j)=sum(sum(F3*A(i: i+2, j+2)));
    end
end
T=15; 
if (I(i,j)>=T)
    I(i,j)=255; 
else 
    I(i,j)=0; 
end

%Displaying result
figure(1), subplot(1, 2, 2), imshow(I, []); title('Point Detection');

%LINE DETECTION 
A=rgb2gray(imread("INSERT IMAGE HERE")); 
figure(2), subplot(1, 2, 1), imshow(A); title("original image"); 
I=zeros(size(A));

% 0 DEGREE LINE 
F3=[-1, -1, -1 ; 2, 2, 2; -1 -1 -1]; 
A=double(A); 
for i=1:size(A, 1)-2
    for j=1:size(A,2)-2
        I(i,j)=sum(sum(F3.*A(i:i+2, j:j+2))); 
    end
end

I=uint8(I);

%THRESHOLDING
T=10; 
if(I(i,j)>=T)
    I(i,j)=255;
else
    I(i,j)=0;
end
%Displaying the result
figure(2), subplot(1, 2, 2), imshow(I, []); title('0 degree Line Detection'); 

% 90 degree line 
F3=[-1, 2, -1 ; -1, 2, -1; -1, 2, -1]; 
A=double(A); 
for i=1:size(A, 1)-2
    for j=1:size(A,2)-2
        I(i,j)=sum(sum(F3.*A(i:i+2, j:j+2))); 
    end
end

I=uint8(I);

%THRESHOLDING
T=10; 
if(I(i,j)>=T)
    I(i,j)=255;
else
    I(i,j)=0;
end
%Displaying thw result
figure(3), subplot(1, 2, 1), imshow(I, []); title('90 degree Line Detection'); 

% 45 degree line 
F4=[-1, -1, 2 ; -1, 2, -1; 2, -1, -1]; 
A=double(A); 
for i=1:size(A, 1)-2
    for j=1:size(A,2)-2
        I(i,j)=sum(sum(F4.*A(i:i+2, j:j+2))); 
    end
end

I=uint8(I);

%THRESHOLDING
T=10; 
if(I(i,j)>=T)
    I(i,j)=255;
else
    I(i,j)=0;
end
%Displaying thw result
figure(3), subplot(1, 2, 2), imshow(I, []); title('45 degree Line Detection'); 
% 45 degree line 
F5=[2, -1, -1 ; -1, 2, -1; -1, -1, 2];
A=double(A); 
for i=1:size(A, 1)-2
    for j=1:size(A,2)-2
        I(i,j)=sum(sum(F5.*A(i:i+2, j:j+2))); 
    end
end

I=uint8(I);

%THRESHOLDING
T=10; 
if(I(i,j)>=T)
    I(i,j)=255;
else
    I(i,j)=0;
end
%Displaying thw result
figure(4), subplot(1, 2, 1), imshow(I, []); title('-45 degree Line Detection'); 


%EDGE DETECTION
a=imread("INSERT IMAGE"); 
a=rgb2gray(a);
b=im2double(a); 
[m,n]=size(a);

%ROBERT OPERATOR 
L(1:m,1:n)=0;
for i=1:m-2; 
    for j=1:n- 2;
        L(i,j)= -1*b(i,j)+0+0+1*b(i+1,j+1);
    end; 
end;
M(1:m,1:n)=0;

for i=1:m-2; 
    for j=1:n- 2;
        M(i,j)= -1*b(i,j+1)+1*b(i+1,j);
    end;
end;

%Displaying Gx and Gy
figure(5), subplot(1, 2, 1), imshow(b), title('ORIGINAL IMAGE'); 
figure(5), subplot(1, 2, 2), imshow(L), title('Robert Gx'); 
figure(6), subplot(1, 2, 1), imshow(M), title('Robert Gy'); 
N=abs(M)+abs(L);

%THRESHOLDING
T=15; %set threshold
if(N(i,j)>=T)
N(i,j)=255;
else
N(i,j)=0;
end

%Displaying the result 
figure(6), subplot(1, 2, 2), imshow(M), title('Robert Gx+Gy');

%PREWITT OPERATOR 
N(1:m,1:n)=0;
for i=1:m-2; 
    for j=1:n- 2;
        N(i,j)= -1*b(i,j)-1*b(i,j+1)- 1*b(i,j+2)+0+0+0+1*b(i+2,j)+1*b(i+2,j+1)+1*b(i+2,j+2); 
    end;
end;
O(1:m,1:n)=0;
for i=1:m-2; 
    for j=1:n- 2;
        O(i,j)= -1*b(i,j)+0+1*b(i,j+2)-1*b(i+2,j)+0+1*b(i+1,j+2)- 1*b(i+2,j)+0+1*b(i+2,j+2); 
    end;
end;

%Displaying Gx and Gy 
figure(7), subplot(1, 2, 1), imshow(N), title('Prewitt Gx');
figure(7), subplot(1, 2, 2), imshow(O), title('Prewitt Gy'); 
Z=abs(N)+abs(O);

%THRESHOLDING
T=15; %set threshold
if(Z(i,j)>=T)
Z(i,j)=255;
else
Z(i,j)=0;
end

%displaying the result
figure(8), imshow(Z), title('Prewitt Gx+Gy');

%SOBEL OPERATOR
P(1:m,1:n)=0;
for i=1:m-2; 
    for j=1:n- 2;
        P(i,j)= -1*b(i,j)-2*b(i,j+1)- 1*b(i,j+2)+0+0+0+1*b(i+2,j)+2*b(i+2,j+1)+1*b(i+2,j+2); 
    end;
end;
R(1:m,1:n)=0;
for i=1:m-2; 
    for j=1:n- 2;
        R(i,j)= -1*b(i,j)+0+1*b(i,j+2)-2*b(i+1,j)+0+2*b(i+1,j+2)- 1*b(i+2,j)+0+1*b(i+2,j+2); 
    end;
end;

%Displaying Gx and Gy 
figure(9), subplot(1, 2, 1), imshow(P), title('Sobel Gx');
figure(9), subplot(1, 2, 2), imshow(R), title('Sobel Gy'); 
Y=abs(P)+abs(R);

%THRESHOLDING
T=15; %set threshold
if(Y(i,j)>=T)
I(i,j)=255;
else
Y(i,j)=0;
end
%displaying the result
figure;imshow(Y); title('Soble Gx+Gy');

clc;
clear all;
close all;
I=imread('image here');
figure
imshow(I);
title('ORIGINAL IMAGE');
Igra1=rgb2gray(I);
figure(1), subplot(621), imshow(Igra1), title('GRAY IMAGE');
Ifil2=medfilt2(Igra1,[3,3]);
figure(1), subplot(622),imshow(Ifil2), title('FILTERED GRAY IMAGE');
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(Ifil2), hy, 'replicate');
Ix = imfilter(double(Ifil2), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
figure(1), subplot(623), imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
L = watershed(gradmag);
figure(1), subplot(624), imshow(L), title("L-GRay");
Lrgb = label2rgb(L);
figure(1), subplot(625), imshow(Lrgb), title('Watershed of gradmag')
se = strel('disk', 20);
Io = imopen(Ifil2, se);
figure(1), subplot(626), imshow(Io), title('Opening (Io)')
Ie = imerode(Ifil2, se);
Iobr = imreconstruct(Ie, Ifil2);
figure(1), subplot(627), imshow(Iobr), title('Opening-by-reconst(Iobr)')
Ioc = imclose(Io, se);
figure(1), subplot(628), imshow(Ioc), title('Opening-closing (Ioc)')
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
figure(1), subplot(6, 2, 9), imshow(Iobrcbr), title('Opening-closing by reconst(Iobrcbr)')
fgm = imregionalmax(Iobrcbr);
figure(1), subplot(6, 2, 10), imshow(fgm), title('Regional maxima of opening-closing')
I21 = Ifil2;
Ifil2(fgm) = 255;
figure(1), subplot(6, 2, 11), imshow(I21), title('Regional maxima superimposed')
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = Ifil2;
I3(fgm4) = 255;
figure(1), subplot(6, 2, 12), imshow(I3)
title('Modified regional maxima superimposed')

bw = imbinarize(Iobrcbr);
figure(2), subplot(421), imshow(bw), title('Thresholded opening-closing of bw')
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
figure(2), subplot(422),imshow(bgm), title('Watershed ridge lines(bgm)')
gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);
I4 = Ifil2;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
figure(2), subplot(423),
imshow(I4)
title('Markers and object boundaries')
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure(2), subplot(424),
imshow(Lrgb)
title('Colored watershed label matrix (Lrgb)')
figure(2), subplot(425),
imshow(Ifil2)
hold on
himage = imshow(Lrgb);
himage.AlphaData = 0.3;
title('Lrgb superimposed transparently')

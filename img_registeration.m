%ROTATE IMG
clc; clear all; close all; 
A=im2gray(imread("insert image here"));

%figure(1), subplot(1,3,1), imshow(A), title("original img");
scale = 0.7;
A1= imresize(A,scale);
theta = 30;
A1= imrotate(A1,theta); % Try varying the angle, theta.
figure(1), subplot(121), imshow(A1), title("distorted img, theta=30, scale=1.5");
movingPoints = [151.52  164.79; 131.40 79.04];
fixedPoints = [135.26  200.15; 170.30 79.30];
tform = fitgeotrans(movingPoints,fixedPoints,'nonreflectivesimilarity');
tformInv = invert(tform);
Tinv = tformInv.T;
ss = Tinv(2,1);
sc = Tinv(1,1);
scale_recovered = sqrt(ss*ss + sc*sc)
theta_recovered = atan2(ss,sc)*180/pi
Roriginal = imref2d(size(A1));
recovered = imwarp(A1,tform,'OutputView',Roriginal);
figure(1), subplot(122), imshow(recovered), title("recovered img");
[optimizer,metric] = imregconfig('monomodal');
movingRegisteredDefault = imregister(A,recovered,'similarity',optimizer,metric, 'PyramidLevels',3);
figure(2), imshowpair(movingRegisteredDefault, A), title('similarity Registration')

%MONOMODAL IMG REGISTRATION 
clc; clear all; close all;
fixed = rgb2gray(imread('insert image 1 here'));
moving = im2gray(imread('insert img 2 here'));
fixed=imresize(fixed, [512, 512]); 
figure(2), imshowpair(moving, fixed, "montage"), title('original imgs');
figure(3), imshowpair(moving, fixed), title('Unregistered');
[optimizer,metric] = imregconfig('monomodal');
movingRegisteredDefault = imregister(moving,fixed,'affine',optimizer,metric, 'PyramidLevels',3);
figure(4), subplot(221), imshowpair(movingRegisteredDefault,fixed), title('Affine Registration')
movingRegisteredDefault = imregister(moving,fixed,'rigid',optimizer,metric, 'PyramidLevels',3);
figure(4),subplot(222),imshowpair(movingRegisteredDefault,fixed), title('Rigid Registration'); 
movingRegisteredDefault = imregister(moving,fixed,'similarity',optimizer,metric, 'PyramidLevels',3);
figure(4),subplot(223),imshowpair(movingRegisteredDefault,fixed), title('Similarity Registration'); 
movingRegisteredDefault = imregister(moving,fixed,'translation',optimizer,metric, 'PyramidLevels',3);
figure(4),subplot(224),imshowpair(movingRegisteredDefault,fixed), title('Translational Registration'); 

%MULTIMODAL 
clc; clear all; close all; 
fixed = rgb2gray(imread('insert image here'));
fixed=imresize(fixed, [512, 512]); 
moving = im2gray(imread('handmri.jpeg'));
figure(5), imshowpair(moving, fixed, 'montage'), title('Original Image');
figure(7), subplot(221),imshowpair(moving, fixed), title('Unregistered');
[optimizer,metric] = imregconfig('multimodal');
movingRegisteredDefault = imregister(moving,fixed,'translation',optimizer,metric, 'PyramidLevels',3);
figure(7), subplot(222), imshowpair(movingRegisteredDefault,fixed), title('Translational Registration')
disp(optimizer);
disp(metric);
optimizer.InitialRadius = optimizer.InitialRadius/1.5;
movingRegisteredAdjustedInitialRadius = imregister(moving,fixed,'translation', optimizer ,metric);
figure(7), subplot(223),imshowpair(movingRegisteredAdjustedInitialRadius,fixed), title('AdjustedRadius')
optimizer.MaximumIterations = 300;
movingRegisteredAdjustedInitialRadius300 = imregister(moving,fixed,'translation',optimizer,metric);
figure(7),subplot(224), imshowpair(movingRegisteredAdjustedInitialRadius300,fixed), title('AdjustRadius, MaximumIterations')


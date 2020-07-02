clear all; clc; 

mainFolder1 = dir('yalefaces_cropped/CroppedYale');
mainFolder1 = mainFolder1(3:length(mainFolder1));
CROP = [];
ave_face = [];
for i=1:length(mainFolder1)
    name = mainFolder1(i).name;
    a = ['yalefaces_cropped/CroppedYale', '/', name];
    subfolder=dir(a);
    subfolder = subfolder(3:end);
    Cropped = [];
    for j = 1:length(subfolder)
        b = [a, '/', subfolder(j).name];
        data = imread(b);
        data = reshape(data,192*168,1);
        Cropped = [Cropped data];
        CROP = [CROP data];
    end
    ave_face = [ave_face sum(Cropped,2)/length(Cropped(1,:))];
end
%%
save CROP.dat CROP -ascii;
save ave_face.dat ave_face -ascii;
%% bring data
clear all; clc; close all;
load CROP.dat;
load ave_face.dat;
%% SVD
CROP = double(CROP);
[U,S,V] = svd(CROP, 'econ');

%% Find singular values 
sig = diag(S);
 plot(sig/sum(sig), 'ro', 'Linewidth', [1.5])
 ylabel('Energy level');
 axis([0 80 0 0.15])
 set(gca, 'Fontsize', [13], 'Xtick', [0 20 40 60 80])
 xlabel('First 80 singular values');
 title('Energy spectrum');
 r = [4, 25, 70, 150, 300];
 reconstruct = U * S(:, 1:50) * V(:, 1:50)';
 
 %%
 figure(2)
 faces = [10, 25, 70, 200];

 for i = 1:length(faces)
    subplot(2,2, i);
    new_image_2 = uint8(reshape(reconstruct(:, faces(i)),243, 320)); %192, 168));
    imshow(new_image_2);
 end
 
 test_file = 'yalefaces_cropped/CroppedYale/yaleB01/yaleB01_P00A+000E+00.pgm';
 test = imread(test_file);
 figure(3)
 subplot(2,3,1)
 imshow(test);
 
 title('original picture')
 test = double(reshape(test, 192 *168, 1));
 %%
 %figure(4)
 for i = 1:length(r)
    U_new = U(:, 1:r(i));
    new_image = U_new * U_new' * test;
    new_image_2 = reshape(new_image, 192, 168);
    subplot(2,3, i + 1);
    imshow(uint8(new_image_2));
    pic_title = ['rank = ', num2str(r(i))];
    title(pic_title)
 end
 %%
 U_new = U(:, 1:4);
new_image = U_new * U_new' * test;
new_image_2 = reshape(new_image, 192, 168);
figure(5)
imshow(uint8(new_image_2));
pic_title = ['rank = 4'];
title(pic_title)

%%
 figure(5)
 for i = 1:4
     figure(i)
     ut1 = reshape(U(:,i), 192, 168);
     ut2=ut1(192:-1:1,:);
     pcolor(ut2)
     set(gca, 'Xtick', [], 'Ytick',[])
     title(['Principal component 0', num2str(i)])
 end
 %%
 figure(2)
     ut1 = reshape(U(:,1), 192, 168);
     ut2=ut1(192:-1:1,:);
     pcolor(ut2)
     set(gca, 'Xtick', [], 'Ytick',[])
     title(['Principal component 0', num2str(1)])
     
     figure(3)
     plot(V(:,1))
     title('V vector: face 1')
     xlabel('feature points')
     ylabel('feature values')
     figure(4)
     plot(V(:,2))
     title('V vector: face 2')
     xlabel('feature points')
     ylabel('feature values')
%% uncropped

UNCROPPED = [];
ave_face = [];
mainFolder2 = dir('yalefaces_uncropped/yalefaces');
mainFolder2 = mainFolder2(3:length(mainFolder2));
for i=1:length(mainFolder2)
    name = mainFolder2(i).name;
    a = ['yalefaces_uncropped/yalefaces', '/', name];
    data = imread(a);
    data = reshape(data,243*320,1);
    UNCROPPED = [UNCROPPED data];
end
UNCROPPED = double(UNCROPPED);
[U,S,V] = svd(UNCROPPED, 'econ');

%% Find singular values 
sig = diag(S);
 subplot(2,1,1)
 plot(sig/sum(sig), 'ro', 'Linewidth', [1.5])
 ylabel('Energy level');
 axis([0 80 0 0.2])
 set(gca, 'Fontsize', [13], 'Xtick', [0 20 40 60 80])
 xlabel('First 80 singular values');
 title('Energy spectrum of Uncropped pictures');
 r = [4, 25, 70, 150, 300];
 reconstruct = U * S(:, 1:50) * V(:, 1:50)';
 
 %%
 figure(3)
 test_file = 'yalefaces_uncropped/yalefaces/subject01.normal';
 test = imread(test_file);
 subplot(3,2, 1)
 imshow(test);
 title('original picture of subject01')
  test_file = 'yalefaces_uncropped/yalefaces/subject04.normal';
 test = imread(test_file);
 subplot(3,2, 3)
 imshow(test);
 title('original picture of subject04')
  test_file = 'yalefaces_uncropped/yalefaces/subject08.normal';
 test = imread(test_file);
 subplot(3,2, 5)
 imshow(test);
 title('original picture of subject08')
 %%
 r = [6, 39, 83];
 name = ['1', '4', '8'];
 for i = 1:length(r)
    new_image_2 = uint8(reshape(reconstruct(:, r(i)),243, 320));
    subplot(3,2, 2*i)
    imshow(new_image_2);
    title_name = ['restored subject0', name(i)];
    title(title_name);
 end
 
 %% testing 
 figure(5)
 for i = 1:4
     figure(i)
     ut1 = reshape(U(:,i), 243, 320);
     ut2=ut1(243:-1:1,:);
     pcolor(ut2)
     set(gca, 'Xtick', [], 'Ytick',[])
     title(['Principal component 0', num2str(i)])
 end
 

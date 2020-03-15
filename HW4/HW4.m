%% yalefaces_cropped
clc; close all; clear all; 

path = 'yalefaces_cropped/CroppedYale/yaleB0';
imagefiles_1 = dir('yalefaces_cropped/CroppedYale/yaleB01/*.pgm');
imagefiles_2 = dir('yalefaces_cropped/CroppedYale/yaleB02/*.pgm');
nfiles = length(imagefiles_1);
m = 192;
n = 168;
rows = m * n;
currentImage = ones(rows, nfiles * 2);
for j = 1 : 1
    for i = 1:nfiles 
        if j == 1
            currentfilename = imagefiles_1(i).name;
            file = strcat(path,'1/', currentfilename);
            val = i;
        else
            currentfilename = imagefiles_2(i).name;
            file = strcat(path,'2/', currentfilename);
            val = i + nfiles;
        end
        currentimage(:,val) = reshape(imread(file), [rows,1]);
    end 
end
%currentimage = dc_wavelet(currentimage);
[U,S,V] = svd(double(currentimage),'econ');
figure(1)
for j = 1:4
    subplot(2,2,j);
    ut1=reshape(U(:,j), 192,168);
    ut2=ut1(80:-1:1,:);
    pcolor(ut2)
    set(gca, 'Xtick', [], 'Ytick' ,[])
end
figure(2)

 sig = diag(S);
plot(sig/sum(sig), 'ko', 'Linewidth', [1.5])
%%
 energy1 = sig(1)/sum(sig);
 energy2 = sum(sig(1:2))/sum(sig);
 energy3 = sum(sig(1:4))/sum(sig);
 subplot(2,1,1)
 plot(sig, 'ko', 'Linewidth', [1.5])
 axis([0 10 0 15000])
 set(gca, 'Fontsize', [13], 'Xtick', [0 2000 4000 6000 12000 14000 15000 ])
%% yalefaces_uncropped

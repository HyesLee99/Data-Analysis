%clc; close all; clear all;
% Plot singular values 
load test1_camera1_x.dat;load test1_camera1_y.dat;
load test1_camera2_x.dat;load test1_camera2_y.dat;
load test1_camera3_x.dat;load test1_camera3_y.dat;

X = [test1_camera1_x';
     test1_camera1_y'; 
     test1_camera2_x';
     test1_camera2_y';
     test1_camera3_x';
     test1_camera3_y'
     ];
 
 [m,n] = size(X);
 [U,S,V] = svd(X'/sqrt(n-1),'econ');
 lambda = diag(S)
 
 sig = diag(S);
 energy1 = sig(1)/sum(sig);
 energy2 = sum(sig(1:2))/sum(sig);
 energy3 = sum(sig(1:4))/sum(sig);
 subplot(2,1,1)
 plot(sig, 'ko', 'Linewidth', [1.5])
 axis([0 10 0 90])
 set(gca, 'Fontsize', [13], 'Xtick', [0 2 4 6 8 10 ])
 
 x = linspace(0,10,226);
 subplot(2,1,2)
 plot(x, U(:,1), 'k',x, U(:,2), 'b',x, U(:,3), 'r', 'Linewidth', [1])
 set(gca, 'Fontsize', [7])
 legend('basis1', 'basis2', 'basis3', 'Location', 'NorthWest')
 
 
% Identify the numbers of singular values 
% calculate energy and select the singular values 
% plot linear POD modes 
% Plot time evolution behavior 
%% test2 

load test2_camera1_x.dat;load test2_camera1_y.dat;
load test2_camera2_x.dat;load test2_camera2_y.dat;
load test2_camera3_x.dat;load test2_camera3_y.dat;

X = [test2_camera1_x';
     test2_camera1_y'; 
     test2_camera2_x';
     test2_camera2_y';
     test2_camera3_x';
     test2_camera3_y'
     ];
 
 [m,n] = size(X);
 [U,S,V] = svd(X'/sqrt(n-1),'econ');
 
 sig = diag(S);
 energy1 = sig(1)/sum(sig);
 energy2 = sum(sig(1:2))/sum(sig);
 energy3 = sum(sig(1:3))/sum(sig);
 energy4 = sum(sig(1:4))/sum(sig);
 subplot(2, 1, 1), plot(sig, 'ko', 'Linewidth', [1.5])
 axis([0 10 0 80])
 set(gca, 'Fontsize', [13], 'Xtick', [0 2 4 6 8 10 ])
 
 x = linspace(0,10,208);
 subplot(2,1,2)
 plot(x, U(:,1), 'k',x, U(:,2), 'b',x, U(:,3), 'r', 'Linewidth', [1])
 set(gca, 'Fontsize', [7])
 legend('basis1', 'basis2', 'basis3', 'Location', 'NorthWest')

%% test 3
clc; clear all; close all;
load test3_camera1_x.dat;load test3_camera1_y.dat;
load test3_camera2_x.dat;load test3_camera2_y.dat;
load test3_camera3_x.dat;load test3_camera3_y.dat;

X = [test3_camera1_x';
     test3_camera1_y'; 
     test3_camera2_x';
     test3_camera2_y';
     test3_camera3_x';
     test3_camera3_y'
     ];
 
 [m,n] = size(X);
 [U,S,V] = svd(X'/sqrt(n-1),'econ');
 
 sig = diag(S);
 energy1 = sig(1)/sum(sig);
 energy2 = sum(sig(1:2))/sum(sig);
 energy3 = sum(sig(1:3))/sum(sig);
 energy4 = sum(sig(1:4))/sum(sig);
 subplot(2, 1, 1), plot(sig, 'ko', 'Linewidth', [1.5])
 axis([0 10 0 80])
 set(gca, 'Fontsize', [13], 'Xtick', [0 2 4 6 8 10 ])
 
 
 x = linspace(0,10,204);
 subplot(2,1,2)
 plot(x, U(:,1), 'k',x, U(:,2), 'b',x, U(:,3), 'r', 'Linewidth', [1])
 set(gca, 'Fontsize', [7])
 legend('basis1', 'basis2', 'basis3', 'Location', 'NorthWest')
%% test 4
clc; clear all; close all;
load test4_camera1_x.dat;load test4_camera1_y.dat;
load test4_camera2_x.dat;load test4_camera2_y.dat;
load test4_camera3_x.dat;load test4_camera3_y.dat;

X = [test4_camera1_x';
     test4_camera1_y'; 
     test4_camera2_x';
     test4_camera2_y';
     test4_camera3_x';
     test4_camera3_y'
     ];
 
 [m,n] = size(X);
 [U,S,V] = svd(X'/sqrt(n-1),'econ');
 
 sig = diag(S);
 energy1 = sig(1)/sum(sig);
 energy2 = sum(sig(1:2))/sum(sig);
 energy3 = sum(sig(1:3))/sum(sig);
 energy4 = sum(sig(1:4))/sum(sig);
 subplot(2, 1, 1), plot(sig, 'ko', 'Linewidth', [1.5])
 axis([0 10 0 80])
 set(gca, 'Fontsize', [13], 'Xtick', [0 2 4 6 8 10 ])
 
 x = linspace(0,10,384);
 subplot(2,1,2)
 plot(x, U(:,1), 'k',x, U(:,2), 'b',x, U(:,3), 'r', 'Linewidth', [1])
 set(gca, 'Fontsize', [5])
 legend('basis1', 'basis2', 'basis3', 'Location', 'NorthWest')
 

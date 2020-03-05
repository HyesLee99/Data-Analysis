clc; close all; clear all; 
%
load('cam1_1.mat'); load('cam2_1.mat'); load('cam3_1.mat'); 
load('cam1_2.mat'); load('cam2_2.mat'); load('cam3_2.mat');
load('cam1_3.mat'); load('cam2_3.mat'); load('cam3_3.mat');
load('cam1_4.mat'); load('cam2_4.mat'); load('cam3_4.mat'); 

size_camera_1 = size(vidFrames1_1);
placement = [0,0];
x_points = size_camera_1(2);
y_points = size_camera_1(1); 
x=linspace(-x_points, x_points);
y=linspace(-y_points, y_points);
[X,Y]=meshgrid(x,y);

placement1_1 = track_can1(vidFrames1_1);
placement2_1 = track_can2(vidFrames2_1); % out of the focus 
placement3_1 = track_can3(vidFrames3_1); % tracks the brightest which is the reflection of the board 

% Cropping the data so that every data has same length 
placement1_1 = placement1_1(2:227, :);
placement2_1 = placement2_1(12:237, :);
placement3_1 = placement3_1(2:227, :);

%% saving the x value and y value for each camera (test 1) 
y_axis = placement1_1(:,1) - mean(placement1_1(:,1));
x_axis = placement1_1(:,2) - mean(placement1_1(:,2));
save test1_camera1_y.dat y_axis -ascii;
save test1_camera1_x.dat x_axis -ascii;
subplot(2,2,1)
plot(y_axis);
hold on 
y_axis = placement2_1(:,1) - mean(placement2_1(:,1));
x_axis = placement2_1(:,2) - mean(placement2_1(:,2));
save test1_camera2_y.dat y_axis -ascii;
save test1_camera2_x.dat x_axis -ascii;
plot(y_axis);
hold on 
y_axis = placement3_1(:,2) - mean(placement3_1(:,2));
x_axis = placement3_1(:,1) - mean(placement3_1(:,1));
save test1_camera3_y.dat y_axis -ascii;
save test1_camera3_x.dat x_axis -ascii;
plot(y_axis);
hold on 
title('test 1')
%% test2 

% make sure to change cropping value for better data 
placement1_2 = track_can1(vidFrames1_2);
placement2_2 = track_can2(vidFrames2_2); 
placement3_2 = track_can3(vidFrames3_2);

% Cropping the data so that every data has same length 
placement1_2 = placement1_2(18:225, :);
placement2_2 = placement2_2(2:209, :);
placement3_2 = placement3_2(20:227, :);

%% saving the x value and y value for each camera (test 2) 
y_axis = placement1_2(:,1) - mean(placement1_2(:,1));
x_axis = placement1_2(:,2) - mean(placement1_2(:,2));
subplot(2,2,2)
plot(y_axis)
hold on 
save test2_camera1_y.dat y_axis -ascii;
save test2_camera1_x.dat x_axis -ascii;
y_axis = placement2_2(:,1) - mean(placement2_2(:,1));
x_axis = placement2_2(:,2) - mean(placement2_2(:,2));
plot(y_axis)
hold on
save test2_camera2_y.dat y_axis -ascii;
save test2_camera2_x.dat x_axis -ascii;
y_axis = placement3_2(:,2) - mean(placement3_2(:,2));
x_axis = placement3_2(:,1) - mean(placement3_2(:,1));
plot(y_axis)
save test2_camera3_y.dat y_axis -ascii;
save test2_camera3_x.dat x_axis -ascii;
title('test 2')

%% test3 

% make sure to change cropping value for better data 
placement1_3 = track_can1(vidFrames1_3);
placement2_3 = track_can2(vidFrames2_3); 
placement3_3 = track_can3(vidFrames3_3);

% Cropping the data so that every data has same length 
placement1_3 = placement1_3(7:210, :); %2
placement2_3 = placement2_3(34:237, :);%29
placement3_3 = placement3_3(2:205, :);

%% saving the x value and y value for each camera (test 3) 
y_axis = placement1_3(:,1) - mean(placement1_3(:,1));
x_axis = placement1_3(:,2) - mean(placement1_3(:,2));
save test3_camera1_y.dat y_axis -ascii;
save test3_camera1_x.dat x_axis -ascii;
subplot(2,2,3)
plot(y_axis)
hold on 
y_axis = placement2_3(:,1) - mean(placement2_3(:,1));
x_axis = placement2_3(:,2) - mean(placement2_3(:,2));
save test3_camera2_y.dat y_axis -ascii;
save test3_camera2_x.dat x_axis -ascii;
plot(y_axis)
hold on
y_axis = placement3_3(:,2) - mean(placement3_3(:,2));
x_axis = placement3_3(:,1) - mean(placement3_3(:,1));
save test3_camera3_y.dat y_axis -ascii;
save test3_camera3_x.dat x_axis -ascii;
plot(y_axis)
hold on
title('test 3')
%% test4 

% make sure to change cropping value for better data 
placement1_4 = track_can1(vidFrames1_4);
placement2_4 = track_can2(vidFrames2_4); 
placement3_4 = track_can3(vidFrames3_4);

% Cropping the data so that every data has same length 
placement1_4 = placement1_4(2:385, :); %2
placement2_4 = placement2_4(7:390, :);%29
placement3_4 = placement3_4(2:385, :);

%% saving the x value and y value for each camera (test 4) 
y_axis = placement1_4(:,1) - mean(placement1_4(:,1));
x_axis = placement1_4(:,2) - mean(placement1_4(:,2));
subplot(2,2,4)
plot(y_axis)
hold on 
save test4_camera1_y.dat y_axis -ascii;
save test4_camera1_x.dat x_axis -ascii;
y_axis = placement2_4(:,1) - mean(placement2_4(:,1));
x_axis = placement2_4(:,2) - mean(placement2_4(:,2));
plot(y_axis)
hold on 
save test4_camera2_y.dat y_axis -ascii;
save test4_camera2_x.dat x_axis -ascii;
y_axis = placement3_4(:,2) - mean(placement3_4(:,2));
x_axis = placement3_4(:,1) - mean(placement3_4(:,1));
plot(y_axis)
hold on
save test4_camera3_y.dat y_axis -ascii;
save test4_camera3_x.dat x_axis -ascii;
title('test 4 ')
%%
load('cam1_1.mat') 
placement2 = track_can1(vidFrames1_1);
for i = 1:314
   imshow(vidFrames1_1(:,:,:,i)), hold on
   %imshow(vidFrames2_1(:,:,:,i)), hold on
   %imshow(vidFrames3_1(:,:,:,i)), hold on
   plot(placement2(i+1,2),placement2(i+1,1),'ro','MarkerSize',10,'MarkerFaceColor','r')
   %plot(placement2(i+1,2),placement2(i+1,1),'ro','MarkerSize',10,'MarkerFaceColor','k')
   %plot(placement3(i+1,2),placement3(i+1,1),'ro','MarkerSize',10,'MarkerFaceColor','b')
   hold off
   pause(0.1)
end

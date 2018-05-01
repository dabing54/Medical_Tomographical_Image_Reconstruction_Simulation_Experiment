% 三维Shepp-Logan头模型仿真方法的参考程序

clc;
% clear all;
close all;
tic
N = 256;  % 重建图像大小，探测器采样点数也设为N
I = zeros( N,  N,  N );  % 存取头模型数据
%%===============定义头模型参数================%%
%          xe            ye              ze             ae            be           ce              phi           gamma      theta            rho
shep = [0              0               0               0.6900    0.9200    0.8100      0              0                 0                  1.0000
              0              -0.0184    0              0.6624    0.8740     0.7800     0               0                 0                 -0.8000
              0.2200    0               0              0.1100    0.3100     0.2200    -18.0000   0                10.0000    -0.2000
             -0.2200    0               0              0.1600    0.4100     0.2800    18.0000    0                10.0000    -0.2000
             0               0.3500     -0.1500   0.2100    0.2500     0.4100     0               0                0                  0.1000
             0               0.1000     0.2500    0.0460    0.0460     0.0500     0               0                0                  0.1000
             0              -0.1000     0.2500    0.0460    0.0460     0.0500     0               0                0                  0.1000
             -0.0800   -0.6050     0              0.0460    0.0230     0.0500     0               0                0                  0.1000
             0              -0.6060     0              0.0230    0.0230     0.0200     0               0                0                  0.1000
             0.0600    -0.6050     0              0.0230    0.0460     0.0200     0               0                0                  0.1000];
toc

%%===================产生三维头部模型==========================%%
tic
I = medfuncSimulationHeadModel(shep, N);
toc

%%===================仿真结果保存与显示==============================%%
tic
filename = strcat( 'Shepp-Logan_3d',  '_',  num2str(N),  '.mat');
save( filename,  'I' ); % 保存为文件
toc 

tic 
figure;  %显示中心断层图像
subplot(131);
imshow(reshape( I ( N / 2,  :,  :),  N,  N ),  [ 0  1.0 ] );
xlabel( ' x = 0处的断面 ' );

subplot(132);
imshow(reshape(I( : ,  N / 2,  :),  N,  N),  [ 0 1.0 ] )
xlabel('y = 0处的断面');

subplot(133);
imshow(reshape(I(  :,  : , N / 2),  N,  N),  [ 0  1.0 ] )
xlabel('z = 0处的断面');
toc
   
   

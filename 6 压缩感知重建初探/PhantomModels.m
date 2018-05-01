clc;
clear all;
close all;
N = 180; % ͼ���С
N2 = 256;
N3 = 512;
N4 = 1024;
I = phantom(N);   % ����ͷģ��ͼ��,��СΪ180x180
I2 = phantom(N2); % ����ͷģ��ͼ��,��СΪ256x256
I3 = phantom(N3); % ����ͷģ��ͼ��,��СΪ512x512
I4 = phantom(N4); % ����ͷģ��ͼ��,��СΪ256x256
subplot(221);
%figure
imshow(I);title('(a)Shepp-Loganͷģ��180x180')
subplot(222);
%figure
imshow(I2);title('(b)Shepp-Loganͷģ��256x256')
subplot(223);
%figure
imshow(I3);title('(b)Shepp-Loganͷģ��512x512')
subplot(224);
%figure
imshow(I4);title('(b)Shepp-Loganͷģ��1024x1024')

%% �Ƚ������˲���ͶӰ�ؽ��Ĳο�����

clc;
clear all;
close all;
%% ================�������=================%
N = 256;        % ͼ���С
I = phantom(N);    % Shepp-Loganͷģ��
SOD = 250;
delta_gamma1 = 2;
delta_gamma2 = 1;
delta_gamma3 = 0.25;

%% ==============��������ͶӰ===============%
R1 = fanbeam(I, SOD, 'FanSensorSpacing', delta_gamma1);
R2 = fanbeam(I, SOD, 'FanSensorSpacing', delta_gamma2);
R3 = fanbeam(I, SOD, 'FanSensorSpacing', delta_gamma3);

%% ==============�ȽǶ�FBP�㷨�ؽ�==========%
rec1 = ifanbeam(R1, SOD, 'FanSensorSpacing',delta_gamma1);
rec2 = ifanbeam(R2, SOD, 'FanSensorSpacing',delta_gamma2);
rec3 = ifanbeam(R3, SOD, 'FanSensorSpacing',delta_gamma3);

%% ===============��ʾ���=================%%
figure;   % ��ʾͼ��
subplot(221);imshow(I, [0,1]),xlabel('(a)256x256ͷģ�ͣ�ԭʼͼ��');
subplot(222);imshow(rec1, [0,1]),xlabel('(b)�����ؽ�ͼ�񣨵ȽǼ��Ϊ2��');
subplot(223);imshow(rec2, [0,1]),xlabel('(c)�����ؽ�ͼ�񣨵ȽǼ��Ϊ1��');
subplot(224);imshow(rec3, [0,1]),xlabel('(d)�����ؽ�ͼ�񣨵ȽǼ��Ϊ0.25��');
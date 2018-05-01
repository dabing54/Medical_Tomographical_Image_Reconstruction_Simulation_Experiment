% ���ý��������Ⱦ�����ͶӰ����Ĳο�����

clc;
clear all;
close all;
%%==========�������============%%
N = 256;  % �ؽ�ͼ���С
N_d = 256;  % ̽����ͨ������
beta = 0 : 1 : 359;  % ��ת�Ƕ�
SOD = 250; % ����
t_max = sqrt(2) * 0.5 * N;   % t�����Χ
delta_dd = SOD * t_max / sqrt(SOD ^ 2 - t_max ^ 2 ) / (N / 2);  % ̽����������
dd = delta_dd * (-N_d / 2 + 0.5 : N_d / 2 - 0.5);  % ̽������������
I = phantom(N);  % ����Shepp-Loganͷģ��
%%===========ͶӰ���ݷ���==============%%
P = medfuncFanBeamDistanceForwardProjection(N, beta, SOD, N_d, dd);
%%===========��������ʾ==============%%
figure(1);
imshow(I, [0 1]);
title('(a)256��256ͷģ��ͼ��');
figure(2);
imagesc(P), colormap(gray), colorbar;
title('(b)360��Ƚ�����ͶӰ����');
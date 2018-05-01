% �Ⱦ�����FBP�㷨�Ĳο�����

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
%%===============�����˲���=================%%
fh_RL = medfuncFanBeamRLFilter2(N_d, delta_dd);
%%==============�˲���ͶӰ==============%%
rec_RL = medfuncFanBeamDistanceFBP(P, fh_RL, beta, SOD, N, N_d, delta_dd);
%%================�����ʾ=================%%
figure;
subplot(121);
imshow(I, []);
title('250��250ͷģ�ͣ�ԭʼͼ��');
subplot(122);
imshow(rec_RL, []);
title('�Ⱦ�����FBP�㷨�ؽ�ͼ��RL������');

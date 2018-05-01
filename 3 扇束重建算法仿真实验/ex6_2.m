%% ���ñ��µĵȽ�����FBP�㷨
%% ===========������=============%%
clc;
clear all;
close all;
%% ===========�������===========%%
N = 256;    % ͼ���С
N_d = 380;  % ̽����ͨ������
beta = 0 : 1 : 359; % ��ת�Ƕ�
SOD = 250;     % ���ࣨ����Դ����ת���ĵľ��룩
delta_gamma = 0.25; % �Ƚ������Ƕȼ��
% delat_gamma = asin(sqrt(2) * 0.5 * N / SOD) / (N_d / 2) * 180 / pi
I = phantom(N);  % ����Shepp_Loganͷģ��
%%===================ͶӰ���ݷ���==========================%%
P = medfuncFanBeamAngleForwardProjection(N, beta, SOD, N_d, delta_gamma);
%%======================�����˲���=========================%%
fh_RL = medfuncFanBeamRLFilter1(N_d, delta_gamma);
%%======================�˲���ͶӰ=========================%%
rec_RL = medfuncFanBeamAngleFBP(P, fh_RL, beta, SOD, N, N_d, delta_gamma);
%%======================��ʾ���===========================%%
figure;
subplot(121);
imshow(I,[]);  
title('(a)256��256ͷģ�ͣ�ԭʼͼ��');
subplot(122);
imshow(rec_RL, []);
title('(b)�Ƚ�����FBP�㷨�ؽ�ͼ��RL������');
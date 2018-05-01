% ʵ��������Ƚ������㷨�Ĳο�����
%%=============������==================%%
clc;
clear all;
close all;
%%==============�������================%%
delta_beta = 1;  % ��ת�Ƕȱ���
beta = 0 : delta_beta : 359;  % ��ת�Ƕ�
N = 256;   % ͼ���С
N_d = 257;  % ̽����ͨ������
SOD = 250; % ����
delta_gamma = 0.25;  % �����Ž����� 
I = phantom(N);   % ����Shepp-Loganͷģ��
%%============ͶӰ���ݷ���===============%%
P = medfuncFanBeamAngleForwardProjection(N, beta, SOD, N_d, delta_gamma);
%%=================���õȽ������ؽ����������ؽ�==================%%
rec_RL = medfuncFanBeamAngleResorting(P, N, SOD, delta_beta, delta_gamma);
%%======================��������ʾ==========================%%
figure
subplot(121);
imshow(I, []);
title('(a)256��256ͷģ�ͣ�ԭʼͼ��');
subplot(122);
imshow(rec_RL, []);
title('(b)�����㷨�ؽ����ͼ��')
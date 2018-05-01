%% ���ý�����

%% ======������===========%%
clc;
clear all;
close all;
%% ======�������==========%%
beta = 0:1:359;      % ��ת�Ƕ�
N = 256;             % ͼ���С
N_d = 379;           % ̽����ͨ������
SOD = 250;           % ����
delta_gamma = 0.25;
I = phantom(N);      % ����Shepp-Loganͷģ��
%% =========ͶӰ���ݷ���=============%%
P = medfuncFanBeamAngleForwardProjection(N, beta, SOD, N_d, delta_gamma);
%% =========�����ʾ================%%
figure;             % ��ʾԭʼͼ��
imshow(I,[0, 1]);
xlabel('(a)256x256ͷģ��ͼ��');
figure;             % ��ʾͶӰ����
imagesc(P),colormap(gray),colorbar;
xlabel('(b)360��Ƚ�����ͶӰ����');
xlabel('ͼ3.7 ���ý������ԵȽ�����ͶӰ�����ݷ���')
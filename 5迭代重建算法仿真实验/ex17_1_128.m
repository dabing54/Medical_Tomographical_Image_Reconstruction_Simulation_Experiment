clc;
clear all;
close all;
N = 128;  % ͼ���С
N2 = N ^ 2;
I = phantom(N);  % ����ͷģ��ͼ��
theta = linspace(0, 180, 61);
theta = theta(1 : 60); % ͶӰ�Ƕ�
%%============����ͶӰ����=============%%
P_num = 185;   % ̽����ͨ������
P = medfuncParallelBeamForwardProjection(theta, N, P_num); % ����ͶӰ����
M = P_num * length(theta);   % ͶӰ���ߵ�������
P = reshape(P, M, 1);
%%====��ȡϵͳ����====%%
delta = 1;  %�������С
[W_ind, W_dat] = medfuncSystemMatrix(theta, N, P_num, delta);
%==============����MLEM�㷨�����ؽ�==============%
F0 = ones(N2, 1);    % ��ʼͼ������
irt_num = 20;    % ��������
F = medfuncMlem1(W_ind, W_dat, N, F0, P, irt_num);
F = reshape(F, N, N)';
%% ==================��������ʾ=================%%
figure(1);
imshow(I), xlabel('(a)128 x 128ͷģ��ͼ��');
figure(2);
imshow(F), xlabel('(b)MLEM�㷨�ؽ���ͼ��')
% ����OSEM�㷨����ͼ���ؽ��Ĳο�����

clc;
clear all;
close all;
N = 128;  % ͼ���С
N2 = N ^ 2;
I = phantom(N);  % ����ͷģ��ͼ��
theta = linspace(0, 180, 61);
theta = theta(1:60); % ͶӰ�Ƕ�

%%===========����ͶӰ����============%%
P_num = 185;  % ̽����ͨ������
P = medfuncParallelBeamForwardProjection(theta, N, P_num);   % ����ͶӰ����
M = P_num * length(theta);  % ͶӰ���ߵ�������
P = reshape(P, M, 1);
%%===========��ȡϵͳ����============%%
delta = 1;  % �����С
[W_ind, W_dat] = medfuncSystemMatrix(theta, N, P_num, delta);
%%============�����Ӽ�============%%

L = 10;  % �Ӽ�����
T = length(theta) / L;   % ÿ���Ӽ������ĽǶ���
theta_seq = reshape(1:length(theta), L, T);  % �����Ƕȱ�ž���
W_index = zeros(L, T * P_num);   % ����L���Ӽ������ߵ��к�
for i = 1:L
    temp = P_num * theta_seq(i, :);
    for j = 1:T
        W_index(i, (j - 1) * P_num + 1 : j * P_num) = temp(j) - P_num + 1 : temp(j);
    end
end

%===============����OSEM�㷨�����ؽ�==================%
F0 = ones(N2, 1);  % ��ʼͼ������
irt_num = 5; % ��������
F = medfuncOsem(W_ind, W_dat, W_index, N, F0, P, irt_num, L);
F = reshape(F, N, N)';
%%=====��������ʾ=====%%
figure(1);
imshow(I), xlabel('(a)128��128ͷģ��ͼ��');
figure(2);
imshow(F), xlabel('(b)OSEM�㷨�ؽ���ͼ��');
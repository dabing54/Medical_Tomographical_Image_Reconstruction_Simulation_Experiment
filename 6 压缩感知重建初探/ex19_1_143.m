% POCS_TVM�㷨�Ĳο�����

clc;
clear all; 
close all;
N = 180;  % ͼ���С
N2 = N ^ 2;
I = phantom(N);  % ����ͷģ��ͼ��
theta = linspace(0, 180, 61);
theta = theta(1:60);  % ͶӰ�Ƕ�
%%========����ͶӰ����=========%%
P_num = 260;  % ̽����ͨ������
P= medfuncParallelBeamForwardProjection(theta, N, P_num);  % ����ͶӰ����
% P = radon(I, theta);
%%=========��ȡͶӰ����=========%%
delta = 1;  % �����С
[W_ind, W_dat] = medfuncSystemMatrix(theta, N, P_num, delta);
%%==========POCS - TVM�㷨===========%%
irt_num = 5;   % �㷨�ܵ�������
F0 = zeros(N2, 1); % ��ʼͼ������
num_TVM = 4;   % ȫ�����С�����̵ĵ�������
lambda = 0.25;  % �ɳ�����
alpha = 0.2;    % ��������
F = medfuncPOCS_TVM(N, W_ind, W_dat, P, irt_num, F0, num_TVM, lambda, alpha);
F = reshape(F, N, N)';  % ת����N��N�ľ���ͼ��
%%==============��������ʾ=================%%
figure(1);
imshow(I);
xlabel('(a)180��180ͷģ��ͼ��');
figure(2);
imshow(F);
xlabel('(b)POCS - TVM�㷨�ؽ���ͼ��')
% SART�㷨�Ĳο�����

clc;
clear all;
close all;
N = 180;
N2 = N ^ 2;
I = phantom(N);
theta = linspace(0, 180, 61);
theta = theta(1:60); % ͶӰ�Ƕ�

%%===========����ͶӰ����============%%
P_num = 260;  % ̽����ͨ������
P = medfuncParallelBeamForwardProjection(theta, N, P_num);   % ����ͶӰ����
% P = radon(I, theta);
%%===========��ȡͶӰ����============%%
delta = 1;  % �����С
[W_ind, W_dat] = medfuncSystemMatrix(theta, N, P_num, delta);
%%============���ò���============%%
F = ones(N2, 1);  % ��ʼͼ������
lambda = 0.5;  % �ɳ�����
c = 0; % ����������
irt_num = 5; % �ܵ�������
while( c < irt_num)
    for j = 1:length(theta)
        W1_ind = W_ind((j - 1) * P_num + 1:j * P_num, :);
        W1_dat = W_dat((j - 1) * P_num + 1:j * P_num, :);
        W = zeros(P_num, N2);
        for jj = 1: P_num
            % ������߲������κ����أ���������
            if ~any(W1_ind(jj, :))
                continue;
            end
            for ii = 1:2*N
                m = W1_ind(jj, ii);
                if m > 0 && m <= N2
                    W(jj, m) = W1_dat(jj, ii);
                end
            end
        end
        sumCol = sum(W)'; % �к�����
        sumRow = sum(W, 2); % �к�����
        ind1 = sumRow > 0;
        corr = zeros(P_num, 1);
        err = P(:, j) - W * F;
        corr(ind1) = err(ind1) ./ sumRow(ind1);   % �������
        backproj = W' * corr;   % ������ͶӰ
        ind2 = sumCol > 0;
        delta = zeros(N2, 1);
        delta(ind2) = backproj(ind2) ./ sumCol(ind2);
        F = F + lambda * delta;
        F(F < 0) = 0;
    end
    c = c + 1;
end
F = reshape(F, N, N)';
figure(1);
imshow(I), xlabel('(a)180��180ͷģ��ͼ��');
figure(2);
imshow(F), xlabel('(b)SART�㷨�ؽ���ͼ��');


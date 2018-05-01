% MART�㷨�Ĳο�����

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
M = P_num * length(theta);
P = reshape(P, M, 1);  % ���г�������


%%===========��ȡͶӰ����============%%
delta = 1;  % �����С
[W_ind, W_dat] = medfuncSystemMatrix(theta, N, P_num, delta);


%%============���ò���============%%
F = ones(N2, 1);  % ��ʼͼ������
var = 0.3;  % �ɳ�����
c = 0; % ����������
irt_num = 5; % �ܵ�������
tic 
while(c < irt_num)
    for i = 1:M
        % ������߲������κ����أ���������
        if any(W_ind(i, :)) == 0
            continue;
        end
        % ����Ȩ��������w
        w = zeros(1, N2);
        ind = W_ind(i, :) > 0;
        w(W_ind(i, ind)) = W_dat(i, ind);
        % ͼ�����һ�ε�������
        PP = w * F;   %ǰ��ͶӰ
        if PP ~= 0
            ind1 = w > 0;
            F(ind1) = (P(i) / PP).^(var * w(ind1)') .* F(ind1);
        end
    end
    c = c + 1;
end
toc
F = reshape(F, N, N)';  % ת����N��N��ͼ�����
%%==================��������ʾ======================%%
figure(1);
imshow(I), xlabel('(a)180��180ͷģ��ͼ��');
figure(2);
imshow(F), xlabel('(b)MART�㷨�ؽ���ͼ��');
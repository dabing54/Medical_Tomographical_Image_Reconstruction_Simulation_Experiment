function F = medfuncPOCS_TVM( N, W_ind, W_dat, P, irt_num, F0, num_TVM, lambda, alpha )
%MEDFUNCPOCS_TVM algorithm
%   ---------------------------------------------------
% �������
% N:ͼ���С
% W_ind:��������������ı�ţ�M��2*N
% W_dat:��������������ĳ��ȣ�M��2*N
% P:ͶӰ����
% irt_num:�㷨���ܵ�������
% F0:��ʼͼ������
% num_TVM:ȫ�����С����TVM�����̵ĵ���������Ĭ��ֵΪ6
% lambda:�ɳ����ӣ�Ĭ��ֵΪ0.25
% alpha: �������ӣ�Ĭ��ֵΪ0.2
% ------------------------------------------------------
% ���������
% F���ؽ���ͼ��
% =====================================================%
if nargin < 6, F0 = zeros(N^2, 1);end
if nargin < 7, num_TVM = 6; end
if nargin < 8, lambda = 0.25; end
if nargin < 9, alpha = 0.2; end
F = F0;  % ��ʼ��ͼ��
N2 = N^2;
% �õ�ÿ��ͶӰ����������P_num��ͶӰ�ĸ���theta_num
[P_num, theta_num] = size(P);
e = 0.00000001;
k1 = 0;  % ѭ�����Ʊ���
while(k1 < irt_num)
    TEMP1 = F;
    %%==================POCS����======================%%
    for j = 1 : theta_num
        for i = 1 : 1 : P_num
            % ȡ��һ�������������������źͳ���
            u = W_ind((j - 1) * P_num + i, :); %���
            v = W_dat((j - 1) * P_num + i, :); %����
            % ������߲������κ����أ���������
            if(any(u) == 0)
                continue;
            end
            % �ָ�ͶӰ����������һ�����߶�Ӧ��������w
            w = zeros(1, N2);
            ind = u > 0;
            w(u(ind)) = v(ind);
            % ͼ�����һ��ART����
            PP = w * F;  % ǰ��ͶӰ
            C = (P(i, j) - PP) / sum(w.^2) *w';  % ������
            F = F + lambda * C;
        end
    end
    F(F < 0) = 0;   % �Ǹ�Լ��
    %%============TVM����====================%%
    d = sqrt((TEMP1 - F)' * (TEMP1 - F));    % ��������
    k2 = 0;
    while(k2 < num_TVM)
        G = zeros(N2, 1);
        for i = 2:N-1
            for j = 2:N-1
                G((j - 1) * N + i) = (2 * F((j - 1) * N + i) - F((j - 1) * N + i - 1) - F((j - 2) * N + i)) / sqrt(e + ...
                    (F((j - 1) * N + i) - F((j - 1) * N + i - 1))^2 + (F((j - 1) * N + i) - F((j - 2) * N + i))^2) -...
                    (F(j * N + i) - F((j - 1) * N + i)) / sqrt(e + (F(j * N + i) - F((j - 1) * N + i))^2 + (F(j * N + i)-...
                    F(j * N + i - 1))^2) -...
                    (F((j - 1) * N + i + 1) - F((j - 1) * N + i) / sqrt(e + (F((j - 1) * N + i + 1) - F((j - 1) * N + i))...
                    ^2 + F((j - 1) * N + i + 1) - F((j - 2) * N + i + 1))^2);
            end
        end
        G = G / sqrt(G' * G);
        F = F - alpha * d * G;
        k2 = k2 + 1;
    end
    k1 = k1 + 1;
end


end


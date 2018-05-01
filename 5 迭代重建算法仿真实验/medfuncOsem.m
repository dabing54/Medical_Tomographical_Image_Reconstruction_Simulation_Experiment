function F = medfuncOsem( W_ind, W_dat, W_index, N, F0, P, irt_num, L )
%MEDFUNCOSEM Summary of this function goes here
%   Detailed explanation goes here

% OSEM(Ordered Subsets Expectation Maximization) algorithm
% -----------------------------------------------------------------------
% ���������
% W_ind:���ߴ�������ı�ţ� M �� 2 * N
% W_dat:���ߴ�������ĳ��ȣ� M �� 2 * N
% W_index:����L�У�T * P_num�У����L���Ӽ���ÿ�������������к�
% F0:��ʼͼ������
% P:ͶӰ���ݣ�������
% irt_num:��������
% L:�Ӽ�����
% -----------------------------------------------------------------------
% ���������
% F:���ͼ������
%========================================================================%
N2 = N^2;
M = length(P); % ���е���������
F = F0;
for k = 1:irt_num
    for kk = 1 : L  % �ӵ���
        w_ind = W_ind(W_index(kk, :), :);
        w_dat = W_dat(W_index(kk, :), :);
        %%============��ʵ��ͶӰ�����ͶӰ�ı�ֵ����=======================%%
        R = zeros(M/L, 1);
        p = P(W_index(kk, :));   % ȡ��ĳһ�Ӽ���Ӧ��ͶӰ����
        for ii = 1:M/L
            %������߲�ͨ���κ����أ���������
            if any(w_ind(ii, :)) == 0
                continue;
            end
            w = zeros(1, N2);
            for jj = 1:2*N
                m = w_ind(ii, jj);
                if m > 0 && m <= N2
                    w(m) = w_dat(ii, jj);
                end
            end
            proj = w * F;  %ǰ��ͶӰ
            R(ii) = p(ii)./proj;   % ��ֵ����
        end
        %%====���ֵ������ȫ1�����ķ�ͶӰback_proj,back_proj0====%%
        back_proj = zeros(N2, 1); 
        back_proj0 = zeros(N2, 1);
        for ii = 1:M/L   % ���У����ߣ��ı��������з�ͶӰ����
            label = w_ind(ii, :);
            data = w_dat(ii, :); % ѭ��������������������
            if any(label) ~= 0  % ������߲�ͨ���κ����أ���������
                ind = label > 0;
                index = label(ind);  % ����Ԫ�ض�Ӧ��������
                back_proj(index) = back_proj(index) + R(ii) * data(ind).';  %��ֵ�����ķ�ͶӰ
                back_proj0(index) = back_proj0(index) + data(ind).';  % ȫ1�����ķ�ͶӰ
            end
        end
        %%=====ͼ���������һ��=====%%
        ind = back_proj0 > 0;
        F(ind) = F(ind) .* (back_proj(ind) ./ back_proj0(ind));
    end
end
end


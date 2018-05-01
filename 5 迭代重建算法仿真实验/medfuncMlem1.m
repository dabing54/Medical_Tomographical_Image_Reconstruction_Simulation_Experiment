function F = medfuncMlem1( W_ind, W_dat, N, F0, P, irt_num )
%MEDFUNCMLEM1 Summary of this function goes here
%   Detailed explanation goes here

%   MLEM(maximum likelihood expectation maximization) algorithm
%   --------------------------------------------
%   ���������
%   W_ind ����������������ı�ţ� M x 2 * N
%   W_dat ����������������ĳ��ȣ� M x 2 * N
%   F0 : ��ʼͼ������
%   P ��ͶӰ���ݣ�������
%   irt_num ����������
%   ---------------------------------------------
%   ���������
%   F �� ���ͼ������
%   ===========================================================%

N2 = N ^ 2; 
M = length(P);   % ���е���������
F = F0;
k = 0;
while(k < irt_num)
    %% ==== ��ʵ��ͶӰ�����ͶӰ�ı�ֵ����====%%
    R = zeros(M, 1);
    for ii = 1 : M
        % ������߲�ͨ���κ����أ���������
        if any(W_ind(ii, :)) == 0
            continue;
        end
        w = zeros(1, N2);   % ϵ�������һ��������
        for jj = 1 : 2 * N
            m = W_ind(ii, jj);
            if m > 0 && m <= N2
                w(m) = W_dat(ii, jj);
            end
        end
        proj = w * F;   % ǰ��ͶӰ
        R(ii) = P(ii) ./ proj;  % ��ֵ����
    end
    %%====���ֵ������ȫ1�����ķ�ͶӰback_proj,back_proj0====%%
    back_proj = zeros(N2, 1);
    back_proj0 = zeros(N2, 1);
    for ii = 1 : M   % ���У����ߣ��ı��������з�ͶӰ����
        label = W_ind(ii, :);
        data = W_dat(ii, :);  % ѭ��������������������
        if any(label) ~= 0  % ������߲�ͨ���κ����أ���������
            ind = label > 0;
            index = label(ind);   % ����Ԫ�ض�Ӧ��������
            back_proj(index) = back_proj(index) + R(ii) * data(ind).';  %��ֵ�����ķ�ͶӰ
            back_proj0(index) = back_proj0(index) + data(ind).';   % ȫ1�����ķ�ͶӰ
        end
    end
    
    %% ====ͼ����µ���һ��====%%
    ind = back_proj0 > 0;
    F(ind) = F(ind) .* (back_proj(ind) ./ back_proj0(ind));
    k = k + 1;
end


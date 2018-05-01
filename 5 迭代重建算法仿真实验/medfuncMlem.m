% ϵ������A�ܹ�����ȫ�洢ʱ��MLEM�㷨�Ĳο�����

function F = medfuncMlem( W, F0, P, irt_num)
%MEDFUNCMLEM Summary of this function goes here
%   Detailed explanation goes here

%   MLEM(maximum likelihood expectation maximization) algorithm
%   --------------------------------------------
%   ���������
%   W ��ϵ�����󣨻���ʾ���
%   F0 : ��ʼͼ������
%   P ��ͶӰ���ݣ�������
%   irt_num ����������
%   ---------------------------------------------
%   ���������
%   F �� ���ͼ������
%   ===========================================================%
sumCol = sum(W).';   % ��ϵͳ������к�����
Wt = W.';
F = F0;
for k = 1 : irt_num
    R = zeros(numel(P), 1);
    proj = W * F;   % ͶӰ����
    ind1 = proj > 0;
    R(ind1) = p(ind1) ./ proj(ind1);    % ʵ��ͶӰ�����ͶӰ�ı�ֵ
    back_proj = Wt * R;  % ��ͶӰ����
    ind2 = sumCol > 0;
    F(ind2) = F(ind2) .* (back_proj(ind2) ./ sumCol(ind2));   % ͼ���������һ��
end
end


function Order_MLS = medfuncMLSOrder( Np )
%MEDFUNCMLSORDER Summary of this function goes here
%   Detailed explanation goes here
%   MLS ͶӰ���ʷ�ʽ������ART�ĵ���˳��
%   ��������������������������������������������������������������������������
%   ˵�������������180ɨ����Ƶģ���ʹ��360��ɨ��ʱ��2��3����˳�򻥻�
%   ���������
%   Np:ͶӰ�Ƕȸ�����projection number�� ��length(theta)
%   ---------------------------------------------------------------------
%   ���������
%   Order_MLS : ��LMS���ʷ�ʽ�ĵ���ͶӰ˳��
%   ======================================================================

L = fix(log2(Np));
if Np > 2 ^ L
    L = L + 1;
end
Order_MLS = zeros(1, Np);
Flag_MLS = zeros(1, Np);
k = 0;
for ii = 1 : L-1
    NL = 2 ^ ii;
    A = bitrevorder(0 : NL - 1);
    B = A(k+1 : end);
    for jj = 1 : length(B)
        k = k + 1;
        M = round((Np / NL) * B(jj));
        Flag_MLS(M + 1) = 1;
        Order_MLS(k) = M;
    end
end

%---------------��L�㴦��-----------------%
NL = 2 ^ L;
A = bitrevorder(0 : NL - 1);
B = A(k + 1 : end);
M = round((Np / NL) * B);
for jj = 1 : length(B)
    M = round((Np / NL) * B(jj));
    if(M < Np) && (M >= 0) && (Flag_MLS(M + 1) == 0)    %% ע��Flag_MLS����Խ������
        k = k + 1;
        Flag_MLS(M + 1) = 1;
        Order_MLS(k) = M;
    elseif(M - 1 < Np) && (M - 1 >= 0) && (Flag_MLS(M) == 0)
        k = k + 1;
        Flag_MLS(M) = 1;
        Order_MLS(k) = M - 1;
    elseif(M + 1 < Np) && (M + 1 >= 0) && (Flag_MLS(M + 2) == 0)
        k = k + 1;
        Flag_MLS(M + 2) = 1;
        Order_MLS(k) = M + 1;
    end
end


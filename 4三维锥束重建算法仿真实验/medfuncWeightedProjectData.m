function RF1 = medfuncWeightedProjectData( RF, N, SOD, dd )
%MEDFUNCWEIGHTEDPROJECTDATA Summary of this function goes here
%   Detailed explanation goes here

RF1 = zeros(N, N);
% weighted projectdata function
% ----------------------------------------------
% �������
% RF�������ͶӰ����
% N ��̽����ͨ������
% SOD ��Դ����ת���ĵľ���
% dd ��̽���������أ�ͨ������С
% ----------------------------------------------
% ���������
% RF1 �� ��Ȩ�˵�ͶӰ���ݾ��� N*N
%================================================%
for k1 = 1:N
    for k2 = 1:N
        RF1(k1, k2) = RF(k1,k2) * SOD / sqrt(SOD^2 + ((k1 - N / 2) * dd) ^ 2 + ((k2 - N / 2) * dd) ^ 2);
    end   
end
end


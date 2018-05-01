function temprec = medfuncBackprojectRecons( dd, D, beta, angle_num, N, Q )
%MEDFUNCBACKPROJECTRECONS Summary of this function goes here
%   Detailed explanation goes here

temprec = zeros(N, N, N);
% �Լ�Ȩ�˲�������ݽ��з�ͶӰ�˲�
% -------------------------------------
% ���������
% dd �� ̽����ͨ����С
% D �� Դ��̽�����ľ���
% beta �� ��ת�Ƕ�
% angle_num �� �ܵ�ͶӰ�Ƕ���Ŀ
% N ���ؽ�ͼ���С
% Q ���˲����theta�Ƕȵ�ͶӰ���ݣ� �����СΪN * N
% -------------------------------------

% ���������
% temprec �� ��ʱ�ؽ���� �����С N * N
%=================================================%
for k1 = 1 : N
    x = dd * (k1 - N / 2);
    for k2  = 1 : N
        y = dd * (k2 - N / 2);
        U = (D + x * sin(beta) - y * cos(beta)) / D;
        a = (x * cos(beta) + y * sin(beta)) / U;
        xx = round(a / dd + N / 2);
        u1 = a / dd + N / 2 - xx;
        for k3 = 1 : N
            z = dd * (k3 - N / 2);
            b = z / U;
            yy = round(b / dd + N / 2);
            u2 = b / dd + N / 2 - yy;
            % ˫���Բ�ֵ
            if(xx >= 1) && (xx < N) && (yy >= 1) && (yy < N)
                temp = (1 - u1) * (1 - u2) * Q(xx, yy) + (1 - u1) * u2 * Q(xx, yy + 1) + u1 *(1 - u2) * Q(xx + 1, yy) + u1 * u2 * Q(xx + 1, yy + 1);
                temprec(k1, k2, k3) = temprec(k1, k2, k3) + temp / U^2 * 2 * pi / angle_num;
            else
                temprec(k1, k2, k3) = temprec(k1, k2, k3);
            end
        end
    end
end


end


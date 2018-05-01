function rec_RL = medfuncFanBeamAngleResorting( P, N, SOD, delta_beta, delta_gamma )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



% �����Ƚ������㷨�������ڲ壩
% ---------------------------
% �������
% P:�Ƚ�����ͶӰ��N_d��beta_num
% N:���ͼ��Ĵ�С
% SOD:���ࣨ����Դ����ת���ĵľ��룩
% delta_beta:��ת�Ƕ�������in degrees��
% delta_gamma:�Ƚ������Ƕȼ��
%------------------------------------
% �������
% rec_RL:�ؽ�����ͼ�񣨴�СN * N��
% ============================================%

[N_d, beta_num] = size(P);  % ��ת�Ƕȸ���
delta_theta = 0.5;  % �Ƕ�
theta = 0 : delta_theta :359;
Np = 257;
Mp = length(theta);  % Np,Mp�ֱ�Ϊ���ź�ƽ����ͶӰ�ĽǶȸ�����̽����ͨ������
delta_gamma = delta_gamma * pi / 180;
delta_theta = delta_theta * pi / 180;
delta_beta = delta_beta * pi / 180;   % �ǶȻ�Ϊ����
d = SOD * sin((N_d - 1) / 2 * delta_gamma) / ((Np - 1) / 2);  % ƽ�й������
pp = zeros(N_d, Mp);
PP = zeros(Np, Mp);  % ��Ų�ֵ�������
% ============��һ����ֵ======================
m1 = zeros(N_d, Mp);
for k1 = 1:N_d
    for k2 = 1:Mp
        t = k2 * (delta_theta / delta_beta) - (k1 - (N_d - 1) / 2 - 1) * (delta_gamma / delta_beta);
        n = floor(t);  % ��������
        m1(k1, k2) = n;
        u = t - n;   % С������
        if n >= 1 && n < beta_num
            pp(k1, k2) = (1 - u) * P(k1, n) + u * P(k1, n + 1);  %���Բ�ֵ
        end
    end 
end

%==============�ڶ�����ֵ===================%
for k1 = 1:Mp
    for k2 = 1:Np
        tt = 1 / delta_gamma * asin((k2 - (Np - 1) / 2 - 1) * d / SOD) + (Np - 1) / 2 + 1;
        m = floor(tt);   % ��������
        uu = tt - m;     % С������
        if m >= 1 && m < N_d
            PP(k2, k1) = (1 - uu) * pp(m, k1) + uu * pp(m + 1, k1);   % ���Բ�ֵ
        end
    end
end

%================ƽ�������˲���ͶӰ�ؽ�===========================%
rec_RL  = iradon(PP, theta, 'linear', 'Ram-Lak', N);

end


function P = medfuncFanBeamDistanceForwardProjection( N, beta, SOD, N_d, dd )
%MEDFUNCFANBEAMDISTANCEFORWARDPROJECTION Summary of this function goes here
%   Fan beam equal distance forward projection function
% -----------------------------------------------------------------
% ���������
% N:ͼ���С
% beta;��ת�Ƕ�ʸ�� in degrees
% SOD:���ࣨ����Դ����ת���ĵľ��룩
% N_d:̽����ͨ������
% gammma:�Ƚ������Ƕ�����
% --------------------------
% ���������
% P:ͶӰ���ݾ���N_d * beta_num��
% =========================================================== %
%%===================����ͷģ��========================%%
% -------------------------------------
% A a b x0 y0 phi
% ------------------------------------
shepp = [1      .69     .92      0      0      0
         -.8    .6624   .8740    0      -.0184 0
         -.2    .1100   .3100    .22    0      -18
         -.2    .1600   .4100    -.22   0      18
         .1     .2100   .2500    0      .35    0
         .1     .0460   .0460    0      .1     0
         .1     .0460   .0460    0      -.1    0
         .1     .0460   .0230    -.08   -.605  0
         .1     .0230   .0230    0      -.606  0
         .1     .0230   .0460    .06    -.605  0
         ];
rho = shepp(:, 1).';   % rho��Բ��Ӧ�ܶ�
ae = 0.5 * N * shepp(:, 2).';   % ae����Բ�̰���
be = 0.5 * N * shepp(:, 3).';   % be����Բ������
xe = 0.5 * N * shepp(:, 4).';   % xe����Բ����x����
ye = 0.5 * N * shepp(:, 5).';   % ye����Բ����y����
alpha = shepp(:, 6).';   % alpha��Բ��ת�Ƕ�
%%=====================ͶӰ��������============================%%
beta = beta * pi / 180;
alpha = alpha * pi / 180;    % �ǶȻ���ɻ���
beta_num = length(beta);
P = zeros(N_d, beta_num);    % ���ͶӰ����
for k1 = 1 : beta_num
    theta = beta(k1) + atan(dd/SOD);
    P_beta = zeros(1, N_d);  %���ÿһ��ת�Ƕ��µ�ͶӰ����
    for k2 = 1 : length(xe)
        rsq  = (ae(k2) * cos(theta - alpha(k2))).^2 + (be(k2) * sin(theta - alpha(k2))).^2;
        dsq = (SOD * dd ./ sqrt(SOD.^2 + dd.^2) - xe(k2) * cos(theta) - ye(k2) * sin(theta)).^2;
        temp = rsq - dsq;
        ind = temp > 0;    % ������ֵ��Ϊ�Ǹ�
        P_beta(ind) = P_beta(ind) + rho(k2) * (2 * ae(k2) * be(k2) * sqrt(temp(ind)))./rsq(ind);
    end
    P(:, k1) = P_beta.';
end

end


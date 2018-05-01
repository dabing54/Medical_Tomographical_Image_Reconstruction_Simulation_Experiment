function rec_RL = medfuncFanBeamAngleFBP( P, fh_RL, beta, SOD, N, N_d, delta_gamma )
%MEDFUNCFANBEAMANGLEFBP Summary of this function goes here
%   Fan beam FBP function for equal angle

% ---------------------------
% �������
% P:ͶӰ���ݾ���
% fh_RL:�˲�����
% beta:��ת�Ƕ�ʸ�� in radians
% SOD:���ࣨ����Դ����ת���ĵľ��룩
% N:���ͼ��Ĵ�С
% N_d;̽����ͨ������
% delta_gamma:�Ƚ������Ƕȼ��
%------------------------------------
% �������
% rec_RL:�ؽ�����ͼ�񣨴�СN * N��
% ============================================%
%%==============�������======================%
delta_gamma = delta_gamma * pi / 180;
gamma = delta_gamma * (-(N_d + 1) / 2 + 1 : (N_d + 1) / 2 - 1);  % �����Ƕ�
beta = beta * pi / 180;
beta_num = length(beta); % ��ת�Ƕȸ���
MX = N;
MY = N;  % �ؽ�ͼ���С
% �������ø���Ȥ�������У�
% roi(1)��roi(2)�ֱ�Ϊx��������С���ֵ
% roi(3)��roi(4)�ֱ�Ϊy��������С���ֵ


%%% roiΪ ����ͼ�� �� ���Ĳ�������  ��ѡһ
% roi = N * [-0.5 0.5 -0.5 0.5]; % ����Ȥ����Ϊ����ͼ��
roi =  N * [-0.25 0.25 -0.25 0.25];  % ����Ȥ����Ϊ���Ĳ�������

hx = (roi(2) - roi(1)) / (MX - 1);  % ����x ��������
xrange = roi(1) + hx * [0:MX-1];    % x��������
hy = (roi(4) - roi(3)) / (MY - 1);  % ����y��������
yrange = flipud((roi(3) + hy * [0 : MY - 1])');  % y��������
x1 = ones(MY, 1) * xrange;  % x�������
x2 = yrange * ones(1, MX);  % y�������
rec_RL = zeros(MX, MY);     % ����ؽ�ͼ������


%% ==============�˲���ͶӰ�ؽ�================ %%
for m = 1: beta_num
    alphaj = beta(m); % ��ת�Ƕ�
    RF1 = P(:, m) .* (SOD * cos(gamma))';   %ͶӰ��������
    C_RL  = conv(RF1, fh_RL, 'same');  % �������
    aj = [cos(alphaj);  sin(alphaj)];
    R = sqrt(x1.^2 + x2.^2);
    L2 = SOD.^2 + R.^2 + 2 * SOD * (x1 * aj(2) - x2 * aj(1));
    t = real(asin((x1 * aj(1) + x2 * aj(2))./sqrt(L2))) / delta_gamma;  %��������
    k = floor(t);  % ������ţ��������֣�
    u = t - k;      % С������
    k = max(1, k + N_d / 2 + 1);  
    k = min(k, N_d - 1);     %�޶�k��ΧΪ1~N_d - 1
    P_RL = ((1 - u).* C_RL(k) + u.* C_RL(k+1));  % �����ڲ�
    rec_RL = rec_RL + P_RL ./ L2 * 2 * pi / beta_num;  % ��ͶӰ�ۼ�
end



end


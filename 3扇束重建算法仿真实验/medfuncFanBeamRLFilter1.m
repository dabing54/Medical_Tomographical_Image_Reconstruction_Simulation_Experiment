function fh_RL = medfuncFanBeamRLFilter1( N_d, delta_gamma )
%MEDFUNCFANBEAMRLFILTER1 Summary of this function goes here
%   Fan beam R - L filter function for equal angle
%-----------------------------------------------
% ���������
% N_d: ̽����ͨ������
% delta_gamma:�ȽǼ��������Ϊ�Ƚ������Ƕȼ����in degrees��
%-----------------------------------------------
% ���������
% fh_RL:�˲�������N_d��1��
%================================================%

delta_gamma = delta_gamma * pi / 180;  % �ǶȻ�Ϊ����
fh_RL = zeros(N_d, 1);
for k1 = 1 : N_d
    fh_RL(k1) = -1 / (2 * pi * pi * sin((k1 - N_d / 2 - 1) * delta_gamma)^2);
    if mod(k1 - N_d / 2 - 1, 2) == 0
        fh_RL(k1) = 0;
    end
end
fh_RL(N_d / 2 + 1) = 1 / (8 * delta_gamma ^ 2);


end


function I = medfuncSimulationHeadModel( shep, N )
%Function of Simulating S_L Head Model

%------------------------------------------
% ���������
% shep : ����ͷģ�Ͳ�������
% N : ͷģ�ʹ�С
%------------------------------------------
% ���������
% I : ͷ��ģ����ά����
%%================================================%%
I = zeros(N, N, N);     % ���ͷģ������

xe = shep(: , 1)'  ;       % ��������x����
ye = shep(: , 2)' ;       % ��������y����
ze = shep(: , 3)' ;       % ��������z����

ae = shep(: , 4)' ;       % ����x�����ϰ��᳤
be = shep(: , 5)' ;       % ����y�����ϰ��᳤
ce = shep(: , 6)' ;       % ����z�����ϰ��᳤

phi = shep(: , 7)' ;      % ������x������ʱ����ת�ĽǶ�
gamma = shep(: , 8)' ;    % ������y������ʱ����ת�ĽǶ�
theta = shep(: , 9)' ;    % ������z������ʱ����ת�ĽǶ�
rho = shep(: , 10)' ;     % �����ܶ�

for k1 = 1 : N
    for k2 = 1 : N
        for k3 = 1 : N
%             k1 = 1 : N;
%             k2 = 1 : N;
%             k3 = 1 : N;
            phi_rad = phi * pi / 180;  % �ǶȻ���ɻ���
            gamma_rad = gamma * pi / 180; % �ǶȻ���ɻ���
            theta_rad = theta * pi / 180; % �ǶȻ���ɻ���
            
            x0 = (k1 - N / 2) / (N / 2);  % ��һ��x����
            y0 = (k2 - N / 2) / (N / 2);  % ��һ��y����
            z0 = (k3 - N / 2) / (N / 2);  % ��һ��z����
            
            cos_phi = cos(phi_rad);
            sin_phi = sin(phi_rad);
            
            cos_gamma = cos(gamma_rad);
            sin_gamma = sin(gamma_rad);
            
            cos_theta = cos(theta_rad);
            sin_theta = sin(theta_rad);
            
            %%=====================������ת����T=========================%%
            %            T = [ T11  T12  T13;
            %                  T21  T22  T23;
            %                  T31  T32  T33];
            
            T11 = cos_theta .* cos_phi - cos_gamma .* sin_phi .* sin_theta;
            T12 = cos_theta .* sin_phi + cos_gamma .* cos_phi .* sin_theta;
            T13 = sin_theta .* sin_gamma;
            
            T21 = -sin_theta .* cos_phi - cos_gamma  .*  sin_phi .*  cos_theta;
            T22 = -sin_theta .* sin_phi + cos_gamma  .*  cos_phi .*  cos_theta;
            T23 = cos_theta .* sin_gamma;
            
            T31 = sin_gamma .* sin_phi;
            T32 = -sin_gamma .* cos_phi;
            T33 = cos_gamma;
            
            %%===================��ԭʼ����㣨x0,y0,z0������תƽ�Ʊ任=====%%
            XX = T11 * x0 + T12 * y0 + T13 * z0;
            YY = T21 * x0 + T22 * y0 + T23 * z0;
            ZZ = T31 * x0 + T32 * y0 + T33 * z0;
            x = XX - xe;
            y = YY - ye;
            z = ZZ - ze;
            ellipsoid = x.^2 ./ ae.^2  +  y.^2 ./ be.^2  +  z.^2 / ce.^2;  % ���򷽳�
            ind = ellipsoid <= 1;  % �жϸĵ��Ƿ���������
            grayval = sum(rho .* ind);    % ����ĵ�Ҷ�ֵ
            I ( k1, k2, k3 ) =  I ( k1, k2, k3 ) + grayval;
        end
    end
end

end


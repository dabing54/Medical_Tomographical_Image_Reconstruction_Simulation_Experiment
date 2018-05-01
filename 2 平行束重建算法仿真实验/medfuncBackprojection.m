function rec = medfuncBackprojection(theta_num, N, P1, delta)
%MEDFUNCBACKPROJECTION Summary of this function goes here
%   Detailed explanation goes here

% Backprojection reconstruction function
% --------------------------
% ���������
% theta_num ��ͶӰ�Ƕȸ���
% N �� ͼ���С��̽����ͨ������
% P1 ��ͶӰ���ݾ���
% delta ���Ƕ����������ȣ�
% ---------------------------

% ���������
% rec �� ��ͶӰ�ؽ�ͼ�����
% =============================================================%
rec = zeros(N);    % �洢�ؽ��������ֵ
for m = 1:theta_num
    pm = P1(:, m); %ȡĳһ�Ƕȵ�ͶӰ����
    Cm = (N/2) * (1 - cos((m - 1) * delta) - sin((m - 1) * delta));
    for k1 = 1:N
        for k2 = 1:N
            % �������������㣬��Ҫע������������nȡֵ��ΧΪ1����N-1
            Xrm = Cm + (k2 - 1) * cos((m - 1) * delta) + (k1 - 1) * sin((m - 1)* delta);
            n = floor(Xrm);  % ������ţ��������֣�
            t = Xrm - floor(Xrm);  % С������
            n = max(1,n); 
            n = min(n,N-1);    % �޶�n��ΧΪ1����N-1
            p = (1 - t) * pm(n) + t * pm(n + 1); % �����ڲ�
            rec(N + 1 - k1, k2) = rec(N + 1 - k1, k2) + p; %��ͶӰ��ͼ����Ҫ��ת90��
        end
    end
   
end


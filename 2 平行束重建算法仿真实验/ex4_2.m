%% ���ý�����ʹ�ò�ͬ�˲����������˲���ͶӰ�ؽ��Ĳο�����%%

%% ======������==========%%
clc;
clear all;
close all;
%% =======�����������================%%
N = 256;                        % �ؽ�ͼ���С��̽������������Ҳ��ΪN
I = phantom(N);                 % Shepp-Loganͷģ��
delta = pi/180;                 % �Ƕ����������ȣ�
theta = 0:1:179;                % ͶӰ�Ƕ�
theta_num = length(theta);
d = 1;                          % ƽ�Ʋ���
%% ========����ͶӰ����===============%%
P = radon(I, theta);                 % radon�任
[mm, nn] = size(P);                  % ����ͶӰ���ݾ�����С��г���
e = floor((mm - N -1)/2 + 1) + 1;    % ͶӰ���ݵ�Ĭ��ͶӰ����Ϊfloor((size(I) + 1)/2)
P = P(e: N + e - 1, :);              % ��ȡ����N�����ݣ���ͶӰ���ݽ϶࣬����������
P1 = reshape(P, N, theta_num);
%% ========�����˲�����===============%%
fh_RL = medfuncRlfilterfunction(N,d);     % R-L�˲�����
fh_SL = medfuncSlfilterfunction(N,d);     % S-L�˲�����
%% =======�˲���ͶӰ�ؽ������þ����===========%%
rec = medfuncBackprojection(theta_num, N, P1, delta);
% ֱ�ӷ�ͶӰ�ؽ���������һʵ���д�ĺ�����
rec_RL = medfuncRLfilteredbackprojection(theta_num, N, P1, delta, fh_RL);
% R-L�����˲���ͶӰ�ؽ�
rec_SL = medfuncSLfilteredbackprojection(theta_num, N, P1, delta, fh_SL);
% S-L�����˲���ͶӰ�ؽ�
%% =============�����˲���ͶӰ�ؽ�===============%%
figure;
subplot(221),imshow(I), xlabel('(a)256x256ͷģ�ͣ�ԭʼͼ��');
subplot(222),imshow(rec,[]),xlabel('(b)ֱ�ӷ�ͶӰ�ؽ�ͼ��');
subplot(223),imshow(rec_RL, []);xlabel('(c)R-L�����˲���ͶӰ�ؽ�ͼ��')
subplot(224),imshow(rec_SL, []);xlabel('(d)S-L�����˲���ͶӰ�ؽ�ͼ��');
% xlabel('ͼ2.25 ���ý����������˲���ͶӰ�ؽ�ͼ��')
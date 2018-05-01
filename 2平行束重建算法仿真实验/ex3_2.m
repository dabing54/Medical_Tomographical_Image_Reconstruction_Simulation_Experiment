% P26 ���ý�����ֱ�ӷ�ͶӰ�ؽ��Ĳο�����

%% =====������====%%
clc;
clear all;
close all;

%% ========ͶӰ��������=============%%
N = 256;
I = phantom(N);     
delta = pi / 180;
theta = 0:1:179;
theta_num = length(theta);

%% ===========����ͶӰ����============%%
P = radon(I,theta);    % radon�任
[mm, nn] = size(P);    % ����ͶӰ������У��г���
e = floor((mm - N - 1)/2 + 1)+1; 
P = P(e : N+e-1 ,: );
P1 = reshape(P, N, theta_num);

%% ===========��ͶӰ�ؽ�===============%%
rec = medfuncBackprojection(theta_num, N, P1, delta);

%% ===========ͶӰ�����ʾ======================%%
figure;
imshow(I, []); title('ԭʼͼ��');xlabel('(a)256x256ͷģ��ͼ��')
figure;
imshow(rec,[]);title('ֱ�ӷ�ͶӰ�ؽ�ͼ��');
xlabel('(b)���ý������õ���ֱ�ӷ�ͶӰ�ؽ�ͼ��')
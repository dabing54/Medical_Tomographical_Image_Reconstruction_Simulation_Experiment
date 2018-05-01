%% ���á�iradon������ʹ�ò�ͬ�˲����������˲���ͶӰ�Ĳο�����%%

clc;
clear all;
close all;
N = 256;
I = phantom(N);
theta = 0:1:179;
P = radon(I,theta);
rec = iradon(P, theta, 'linear', 'None');
rec_RL = iradon(P, theta);
rec_SL = iradon(P, theta, 'linear', 'Shepp-Logan');
figure;
subplot(221);imshow(I),title('ԭʼͼ��');
subplot(222);imshow(rec, []), title('ֱ�ӷ�ͶӰ�ؽ�ͼ��');
subplot(223);imshow(rec_RL, []),title('R-L�����˲���ͶӰ�ؽ�ͼ��');
subplot(224);imshow(rec_SL, []),title('S-L�����˲���ͶӰ�ؽ�ͼ��');
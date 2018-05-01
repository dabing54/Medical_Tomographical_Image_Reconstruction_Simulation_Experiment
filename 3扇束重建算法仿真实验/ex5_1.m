%%���Ƚ�����ͶӰ���ݷ���Ĳο�����

clc;
clear all;
close all;
%% =======���ò���==============%%
N = 256;              % ͼ���С
SOD = 250;            % ���ࣨ����Դ����ת���ĵľ��룩
delta_gamma = 0.25;   % �Ƚ������Ƕȼ��
%% =======���ɷ�������===========%%
I = phantom(N);       % ����Shepp-Loganͷģ��
P = fanbeam(I, SOD, 'FanSensorSpacing', delta_gamma);   %����ͶӰ����
%% =======��������ʾ===========%%
figure;               % ��ʾԭʼͼ��
imshow(I,[0, 1]);
xlabel('(a)256x256ͷģ��ͼ��');
figure;               % ��ʾͶӰ����
imagesc(P),colormap(gray),colorbar;
xlabel('(b)360��Ƚ�����ͶӰ����');
%xlable('ͼ3.6 ����"fanbeam"�����ԵȽ�����ͶӰ�ķ�����')
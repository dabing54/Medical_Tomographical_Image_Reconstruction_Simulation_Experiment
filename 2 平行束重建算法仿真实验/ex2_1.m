% ����Radon�任����ƽ����ͶӰ���ݵĲο�����
clc;
clear all;
close all;
I = phantom(256);     %���ɣ���������������Shepp-Loganͷģ��
figure;               %��ʾԭʼͼ��
imshow(I,[]),title('256*256ͷģ��ͼ��');xlabel('(a)256x256ͷģ��ͼ��')


theta = 0:1:179;        %ͶӰ�Ƕ�
sprintf('theta = %d', theta);
P = radon(I,theta);   %����ͶӰ����
%     pause(2)
%��ʾͶӰ��
figure;
 imagesc(P), colormap(gray), colorbar,title('180��ƽ����ͶӰͼ��')
 xlabel('(b)����Radon�任�õ���ƽ����ͶӰ')



% figure;               %��ʾԭʼͼ��
% imshow(I,[]),title('256*256ͷģ��ͼ��');xlabel('(a)256x256ͷģ��ͼ��')
% figure;               %��ʾͶӰ����
% imagesc(P), colormap(gray), colorbar,title('180��ƽ����ͶӰͼ��')
% xlabel('(b)����Radon�任�õ���ƽ����ͶӰ')
 
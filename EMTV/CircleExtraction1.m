clc;
clear all;
close all;

%% 1 ��ȡԭʼͼ��
I = imread('lena.jpg');
imshow(I);
[Length, Width] = size(I);
I(256,256)

%% 2 ѡ������Բ�ģ�ԭʼͼ��512*512��ѡ��Բ��Ϊ(u, v) = ��256,256��
     % ��ȡָ���뾶ƽ����Բ������ 
u = 256;
v = 256; % Բ������

F = zeros(Length);
C = 25600; % Բ�İ뾶��ƽ��
for i = 1:Length;
    for j = 1:Width
        if((i - u)^2 + (j - v)^2 <= C)
            F(i, j) = I(i, j);
        end
    end
end

%% 3 ��ʾԲ��ȡ���ͼ��
sprintf('��ȡָ���뾶ƽ����Բ������')
figure
imshow(F, [0 255])
impixelregion
title('��ȡ�뾶ƽ��Ϊ100��Բ������')

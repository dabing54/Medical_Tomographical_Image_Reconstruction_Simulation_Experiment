clc;
clear all;
close all;

% %% ����ͼ��
% N = 256; % ͼ���С
% I = phantom(N);   % ����ͷģ��ͼ��,��СΪ180x180
% subplot(121)
% imshow(I);impixelregion;
% title('(a)Shepp-Loganͷģ��180x180')


% %% ����ͼ��
I = imread('lena.jpg');
figure;
subplot(121);imshow(I);%impixelregion
title('(a)Origin Image')
length(I)

tic
%%% ���޲���㷨
F = zeros(size(I));
F(1, :) = I(1, :);
F(:, 1) = I(:, 1);
for i = 2 : length(I)
    for j = 2 : length(I)
        % ���޲��ͼ��
            F(i, j) = ( sqrt(  ( double(I(i, j)) - double(I(i-1, j)) ) ^ 2) + sqrt( ( double(I(i, j)) - double(I(i, j-1)) ) ^ 2 ) ) ^ 0.5;
    end
end
toc

% F = FiniteDifference(I, N);
subplot(122)
imshow(F);
title('(b)���޲��ͼ��');
impixelregion

%% ϡ�軯���ͼ�񣬻Ҷ�ֵ����0�ĸ�������
%  �Լ�ռ��
count_zero = 0;
for i = 1 : length(F)
    for j = 1 : length(F)
        if( F(i, j) == 0 )
            count_zero = count_zero + 1;
        end
    end
end
sprintf('count_zero = ')
count_zero
ratio = count_zero / (512^2)
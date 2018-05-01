%  P26, ���á�iradon��������ֱ�ӷ�ͶӰ�ؽ��Ĳο�����

% clc;
% clear all;
% close all;
% I = phantom(256);                         % ����256*256��Shepp_Loganͷ��ģ��
% theta = 0:179;                            % ͶӰ�Ƕ�180��
% P = radon(I,theta);                       % ����ͶӰ����
% rec = iradon(P, theta, 'None');           % ֱ�ӷ�ͶӰ�ؽ����������˲�����Ϊֱ�ӷ�ͶӰ�ؽ���
% figure;                                   % ��ʾԭʼͼ��
% imshow(I,[]),title('ԭʼͼ��');
% xlabel('(a)256x256ͷģ��ͼ��')
% figure;                                   % ��ʾ�ؽ���ͼ��
% imshow(rec,[]);title('ֱ�ӷ�ͶӰ�ؽ�ͼ��');impixelregion
% xlabel('(b)����"radon"�����õ���ֱ�ӷ�ͶӰ�ؽ�ͼ��')
% 
% 



clc;
clear all;
close all;


I = phantom(256);                         % ����256*256��Shepp_Loganͷ��ģ��
figure;                                   % ��ʾԭʼͼ��
imshow(I,[]),title('ԭʼͼ��');
xlabel('(a)256x256ͷģ��ͼ��')



for theta = 0:1:179;                            % ͶӰ�Ƕ�180��
    P = radon(I,theta);                       % ����ͶӰ����
    rec = iradon(P, theta, 'None');           % ֱ�ӷ�ͶӰ�ؽ����������˲�����Ϊֱ�ӷ�ͶӰ�ؽ���
    figure;                                   % ��ʾ�ؽ���ͼ��
    pause(2);
    imshow(rec,[]);title('ֱ�ӷ�ͶӰ�ؽ�ͼ��');
    % impixelregion
    xlabel('(b)����"radon"�����õ���ֱ�ӷ�ͶӰ�ؽ�ͼ��')
end




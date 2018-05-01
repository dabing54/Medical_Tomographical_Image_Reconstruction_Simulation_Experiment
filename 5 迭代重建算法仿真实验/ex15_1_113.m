% �Ƚϲ�ͬ��ͶӰ���ʷ�ʽ��ART�ؽ�����
% �Ƚϲ�ͬ��ͶӰ���ʷ�ʽ�Ե����ؽ���Ӱ��
% 1��˳����ʷ�ʽ
% 2��MLS���ʷ�ʽ

clf;
clc;
clear all;
close all;
N = 180; % ͼ���С
N2 = N ^ 2;
I = phantom(N);  % ����ͷģ��ͼ��
Image = reshape(I', N2, 1);
theta = linspace(0, 180, 91);
theta = theta(1 : 90);  % ͶӰ�Ƕ�

%%================����ͶӰ����====================%%
P_num = 200;  % ̽����ͨ������
p = medfuncParallelBeamForwardProjection(theta, N, P_num);  % ����ͶӰ����
%%================��ȡϵͳ����=========================%%
delta = 1;  % �����С
[W_ind, W_dat] = medfuncSystemMatrix(theta, N, P_num, delta);
%%=================ART������������=========================%%
lambda = 0.5;  % �ɳ�����
c = 0;  % ����������
irt_num = 5;    % �ܵ�������
theta_num = length(theta);   % ͶӰ�Ƕȸ���
err1 = zeros(irt_num + 1, 1);  %���ͼ�����
err2 = zeros(irt_num + 1, 1);
E1_art = zeros(N2, 1); % ��ʼͼ������
E1_art_mls = zeros(N2, 1); 

%%==================�������߽���ART����======================%%
%%------------------art˳��---------------------%%
sq_error = sum( ( Image - mean(Image) ) .^ 2);
err1(c + 1) = sqrt( sum ( ( Image - E1_art ) .^ 2 )  /  sq_error );  % ��һ����������d
tic
while(c < irt_num)
    for j = 1 : theta_num
        for i = 1 : 1 : P_num
            % ���һ������Ȩ���������ļ���
            u = W_ind( ( j - 1 ) * P_num + i,  :);
            v = W_dat( ( j - 1 ) * P_num + i,  :);
            % �������õ�ĳһͶӰϵ�����������е���
            if any(u) == 0
                continue;
            end
            w = zeros(1, N2);
            ind = u > 0;
            w( u ( ind ) ) = v( ind );
            PP = w * E1_art;
            C = ( p ( i,  j ) - PP) / sum( w .^ 2 ) *  w';
            E1_art = E1_art + lambda * C;
        end
    end
    E1_art ( E1_art < 0 ) = 0;
    c = c + 1;
    err1( c + 1 ) = sqrt( sum ( ( Image - E1_art )  .^  2 )  / sq_error);
end
toc
plot( 0 : irt_num, err1, 'r-- *' );
c = 0; clear C; clear w; clear u; clear v; clear err; clear cc;
%%-----------------art-mls--------------------%%
err2( c + 1 ) = sqrt( sum ( ( Image - E1_art_mls ) .^ 2)  /  sq_error );
Order_MLS = medfuncMLSOrder( theta_num ) + 1;
tic
while(c < irt_num)
    for j = Order_MLS
        for i = 1 : 1 : P_num
            % ���һ������Ȩ���������ļ���
            u = W_ind((j - 1)  *  P_num + i,  :);
            v = W_dat((j - 1)  *  P_num + i,  :);
            % �������õ�ĳһͶӰϵ�����������е���
            if any(u) == 0
                continue;
            end
            w = zeros(1, N2);
            ind = u > 0;
            w( u( ind ) ) = v( ind );
            PP = w * E1_art_mls;
            C = ( p(i,  j) - PP )  / sum( w .^ 2 )  *  w';
            E1_art_mls = E1_art_mls + lambda * C;
        end
    end
    E1_art_mls(E1_art_mls < 0) = 0;
    c = c + 1;
    err2(c + 1) = sqrt( sum ( ( Image - E1_art_mls ) .^ 2 )  / sq_error );
end
toc

hold on;  plot(0 : irt_num, err2, 'g-*');
title('error between original and reconstruction');
legend('sequence', 'MLS'); xlabel('��������'); ylabel('��һ����������itd');
%%-------------------------ת����NxN��ͼ�����---------------------------%%
E1_art = reshape(E1_art, N, N)';
E1_art_mls = reshape(E1_art_mls, N, N)';
%%=========================show images===========================%%
figure
subplot(131);imshow(I),title('Original image')
subplot(132);imshow(E1_art), title('sequence access');
subplot(133);imshow(E1_art_mls),title('MLS access');
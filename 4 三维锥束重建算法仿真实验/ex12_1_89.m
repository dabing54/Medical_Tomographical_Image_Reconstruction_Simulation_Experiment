%  ��ά׶��FDK�㷨�Ĳο�����˵����Ϊ��С�ؽ�ʱ�䣬ʵ��ʱ����ѡȡN = 128����64�������ؽ���

clc;
% clear all;
close all;

sprintf('�������ݣ������������ʱ�䣺')
tic
N = 256;  %�ؽ�ͼ���С��̽������������
load '3Dprojection_256.mat';   %����ͶӰ����
angle_range = 360;    % ��ת�Ƕ�0-2pi��Ĳ�������
SOD = 44;   % Դ��̽�������ĵľ���
SDD = 2 * SOD;   % Դ��̽�������ĵľ���
virtual_detector_length = 2;   % ����̽��������
detector_length = virtual_detector_length * SDD / SOD;   % ̽��������
detector_channel_size = detector_length/N;      % ̽�����ĵ�λ����
rampfilter = zeros(1, N);   % ���б���˲�����

%% ---------------------------
project_beta = zeros(N, N);  % ���beta�Ƕȵ�ͶӰ����
weighted_project_beta = zeros(N ,N); % ���Ԥ��Ȩ��ͶӰ����
filtered_project = zeros(N, N);  % ����˲����ͶӰ����
rec = zeros(N, N, N);     % ����ؽ����
toc

%% �˲������  %%
sprintf('�˲����������ʱ�䣺')
tic
Nfft = 2 ^ nextpow2(2 * N - 1);
rampfilter = zeros(1, Nfft);     % ���б���˲�����
for k1 = 1 : Nfft
    rampfilter(k1) = -1 / (pi * pi * ((k1 - Nfft / 2 - 1)^2));
    if mod(k1 - Nfft/2 - 1, 2) == 0
        rampfilter(k1) = 0;
    end
end

rampfilter(Nfft / 2 + 1) = 1 / 4;
H = fft(rampfilter);
H0 = abs(H)';
toc

%%=================FDK�ؽ��㷨====================%%
sprintf('FDK�ؽ��㷨������ʱ���ǣ�')
tic
for m = 1 : angle_range
    beta = (m - 1) * pi / 180;    % ��ת�Ƕȣ����ȣ�
    project_beta = P(:, :, m);
    %%%==============��Ȩ==================%
    weighted_project_beta = medfuncWeightedProjectData(project_beta, N, SOD, detector_channel_size);
    %%============�˲�============%%
    filtered_project = medfuncFFtRampFilter(weighted_project_beta, H0, N);
    %%============��ͶӰ=============%%
    rec = rec + medfuncBackprojectRecons(detector_channel_size, SOD, beta, angle_range, N, filtered_project);
end
toc

%%%============�ؽ������������ʾ================%

sprintf('�ؽ������������ʾ����ʱ�䣺')
tic
rec = rec * pi / 180 / detector_channel_size;
filename = strcat('zhuishu_recconstruction', '_', num2str(N), '.mat');
save(filename, 'rec');
figure;
subplot(131), imshow(reshape(rec(N / 2, :, :), N, N), []), xlabel('x = 0���Ķ���');
subplot(132), imshow(reshape(rec(:, N / 2, :), N, N), []), xlabel('y = 0���Ķ���');
subplot(133), imshow(reshape(rec(:, :, N / 2), N, N), []), xlabel('z = 0���Ķ���');


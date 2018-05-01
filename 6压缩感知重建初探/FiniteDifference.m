function F = FiniteDifference( I, N)
%FINITEDIFFERENCE Summary of this function goes here
%   Detailed explanation goes here

% ͼ���С
F = zeros(N);
F(1, :) = I(1, :);
F(:, 1) = I(:, 1);
for i = 2 :N
    for j = 2 :N
        % ���޲��ͼ��
            F(i, j) = ( sqrt(  ( I(i, j) - I(i-1, j) ) ^ 2) + sqrt( ( I(i, j) - I(i, j-1) ) ^ 2 ) ) ^ 0.5;
    end
end
end


clear all; close all; clc;
load('../图像处理所需资源/hall.mat');
load('../图像处理所需资源/JpegCoeff.mat');
hall_pre = double(hall_gray) - 128;
hall_quan = blockproc(hall_pre, [8, 8], @(mat)(zig_zag(round(dct2(mat.data) ./ QTAB))));
[height, width] = size(hall_quan);
res = zeros([64, height * width / 64]);
for i = 0: 1: height / 64 - 1
    for j = 1: 1: width
        res(:, i * width + j) = hall_quan(i * 64 + 1: (i + 1) * 64, j);
    end
end

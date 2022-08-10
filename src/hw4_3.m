clear all; close all; clc;
load("../图像处理所需资源/hall.mat");
[height, width] = size(hall_gray);
hall_part = double(hall_gray(1: height / 1, 1: width / 1)) - 128;
hall_part = blockproc(hall_part, [8, 8], @(mat)(dct2(mat.data)));
hall_origin = uint8(blockproc(hall_part, [8, 8], @(mat)(idct2(mat.data) + 128)));

hall_right = blockproc(hall_part, [8, 8], @(mat)(ClearRight(mat.data)));
hall_right_origin = uint8(blockproc(hall_right, [8, 8], @(mat)(idct2(mat.data)) + 128));

hall_left = blockproc(hall_part, [8, 8], @(mat)(ClearLeft(mat.data)));
hall_left_origin = uint8(blockproc(hall_left, [8, 8], @(mat)(idct2(mat.data)) + 128));

subplot(1, 3, 1);
imshow(hall_origin);
title("hall\_origin");
subplot(1, 3, 2);
imshow(hall_right_origin);
title("hall\_right");
subplot(1, 3, 3);
imshow(hall_left_origin);
title("hall\_left");

function mat = ClearRight(mat)
    [~, w] = size(mat);
    mat(:, w - 3: w) = 0;
end

function mat = ClearLeft(mat)
    mat(:, 1: 4) = 0;
end

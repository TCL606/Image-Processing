clear all; close all; clc;
load("../图像处理所需资源/hall.mat");
[height, width] = size(hall_gray);
hall_init = double(hall_gray(1: height / 1, 1: width / 1)) - 128;
hall_part = blockproc(hall_init, [8, 8], @(mat)(dct2(mat.data)));
hall_origin = uint8(blockproc(hall_part, [8, 8], @(mat)(idct2(mat.data) + 128)));

hall_tran = blockproc(hall_init, [8, 8], @(mat)(dct2(mat.data)'));
hall_tran_origin = uint8(blockproc(hall_tran, [8, 8], @(mat)(idct2(mat.data) + 128)));

hall_90 = blockproc(hall_part, [8, 8], @(mat)(rot90(mat.data)));
hall_90_origin = uint8(blockproc(hall_90, [8, 8], @(mat)(idct2(mat.data) + 128)));

hall_180 = blockproc(hall_part, [8, 8], @(mat)(rot90(mat.data, 2)));
hall_180_origin = uint8(blockproc(hall_180, [8, 8], @(mat)(idct2(mat.data) + 128)));

subplot(1, 4, 1);
imshow(hall_origin);
title("hall\_origin");
subplot(1, 4, 2);
imshow(hall_tran_origin);
title("hall\_transpose");
subplot(1, 4, 3);
imshow(hall_90_origin);
title("hall\_90");
subplot(1, 4, 4);
imshow(hall_180_origin);
title("hall\_180");

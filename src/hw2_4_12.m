clear all; close all; clc;
load('../图像处理所需资源/hall.mat');
load('../图像处理所需资源/JpegCoeff.mat');

QTAB = QTAB / 2;
[dc_code, ac_code, img_height, img_width] = Compress(hall_gray, DCTAB, ACTAB, QTAB);
compress_rate = img_height * img_width * 8 / (length(dc_code) + length(ac_code));
hall_decompress = Decompress(dc_code, ac_code, img_height, img_width, DCTAB, ACTAB, QTAB);
mse = sum((double(hall_gray) - double(hall_decompress)).^2, 'all') / img_height / img_width;
psnr = 10 * log10(255^2 / mse);
disp("PSNR = " + psnr);
disp("Compress Rate = " + compress_rate);

subplot(1, 2, 1);
imshow(hall_gray);
title('Origin');
subplot(1, 2, 2);
imshow(hall_decompress);
title('Decompress');

clear all; close all; clc;
load('../图像处理所需资源/snow.mat');
load('../图像处理所需资源/JpegCoeff.mat');

[dc_code, ac_code, img_height, img_width] = Compress(snow, DCTAB, ACTAB, QTAB);
cprate = img_height * img_width * 8 / (length(dc_code) + length(ac_code));
dcp_snow = Decompress(dc_code, ac_code, img_height, img_width, DCTAB, ACTAB, QTAB);
[img_height, img_width] = size(dcp_snow);
mse = sum((double(snow) - double(dcp_snow)).^2, 'all') / img_height / img_width;
psnr = 10 * log10(255^2 / mse);
disp("PSNR = " + psnr);
disp("Compress Rate = " + cprate);

subplot(1, 2, 1);
imshow(snow);
title('Origin');
subplot(1, 2, 2);
imshow(dcp_snow);
title('Decompress');

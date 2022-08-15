clear all; close all; clc;
load('../图像处理所需资源/hall.mat');
load('../图像处理所需资源/JpegCoeff.mat');

[height, width] = size(hall_gray);
info_1 = int32(randi([0, 1], 64, height * width / 64));
[dc_code_1, ac_code_1, img_height, img_width] = dct_conceal_1(hall_gray, info_1, DCTAB, ACTAB, QTAB);
[reveal_info_1, reveal_img_1] = dct_reveal_1(dc_code_1, ac_code_1, img_height, img_width, DCTAB, ACTAB, QTAB);

threshold = 12;
less_thre = QTAB <= threshold;
less_thre_idx = find(less_thre);
num_less_thre = sum(less_thre, 'all');
info_2 = int32(randi([0, 1], num_less_thre, height * width / 64));
[dc_code_2, ac_code_2, img_height, img_width] = dct_conceal_2(hall_gray, info_2, less_thre_idx, DCTAB, ACTAB, QTAB);
[reveal_info_2, reveal_img_2] = dct_reveal_2(dc_code_2, ac_code_2, img_height, img_width, less_thre_idx, DCTAB, ACTAB, QTAB);

info_3 = randi([0, 1], 1, height * width / 64);
info_3 = int32((info_3 - 0.5) * 2);
[dc_code_3, ac_code_3, img_height, img_width] = dct_conceal_3(hall_gray, info_3, DCTAB, ACTAB, QTAB);
[reveal_info_3, reveal_img_3] = dct_reveal_3(dc_code_3, ac_code_3, img_height, img_width, DCTAB, ACTAB, QTAB);

acc_1 = sum(reveal_info_1 == info_1, 'all') / img_height / img_width;
acc_2 = sum(reveal_info_2 == info_2, 'all') / img_height / img_width * 64 / num_less_thre;
acc_3 = sum(reveal_info_3 == info_3, 'all') / img_height / img_width * 64;
disp("=====================   ACC  =====================");
disp("dct_hide_1 ACC = " + acc_1);
disp("dct_hide_2 ACC = " + acc_2);
disp("dct_hide_3 ACC = " + acc_3);

compress_rate_1 = img_height * img_width * 8 / (length(dc_code_1) + length(ac_code_1));
compress_rate_2 = img_height * img_width * 8 / (length(dc_code_2) + length(ac_code_2));
compress_rate_3 = img_height * img_width * 8 / (length(dc_code_3) + length(ac_code_3));
disp("=====================   Compress Rate  =====================");
disp("compress_rate_1 = " + compress_rate_1);
disp("compress_rate_2 = " + compress_rate_2);
disp("compress_rate_3 = " + compress_rate_3);

psnr_1 = 10 * log10(255^2 / (sum((double(hall_gray) - double(reveal_img_1)).^2, 'all') / img_height / img_width));
psnr_2 = 10 * log10(255^2 / (sum((double(hall_gray) - double(reveal_img_2)).^2, 'all') / img_height / img_width));
psnr_3 = 10 * log10(255^2 / (sum((double(hall_gray) - double(reveal_img_3)).^2, 'all') / img_height / img_width));
disp("=====================   PSNR   =====================");
disp("psnr_1 = " + psnr_1);
disp("psnr_2 = " + psnr_2);
disp("psnr_3 = " + psnr_3);

subplot(2, 2, 1);
imshow(hall_gray);
title('Origin');
subplot(2, 2, 2);
imshow(reveal_img_1);
title('Reveal 1');
subplot(2, 2, 3);
imshow(reveal_img_2);
title('Reveal 2');
subplot(2, 2, 4);
imshow(reveal_img_3);
title('Reveal 3');

clear all; close all; clc;
load('../图像处理所需资源/hall.mat');
load('../图像处理所需资源/JpegCoeff.mat');

[height, width] = size(hall_gray);
rand_info = logical(randi([0, 1], height, width));
hall_hide = bitset(hall_gray, 1, rand_info);
[dc_code, ac_code, img_height, img_width] = Compress(hall_hide, DCTAB, ACTAB, QTAB);
hall_decompress = Decompress(dc_code, ac_code, img_height, img_width, DCTAB, ACTAB, QTAB);
decode_info = bitand(hall_decompress, uint8(ones([height, width])));
acc = sum(decode_info == rand_info, 'all') / height / width;
disp("ACC = " + acc);

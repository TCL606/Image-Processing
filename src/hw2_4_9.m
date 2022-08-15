clear all; close all; clc;
load('../图像处理所需资源/hall.mat');
load('../图像处理所需资源/JpegCoeff.mat');

[dc_code, ac_code, img_height, img_width] = Compress(hall_gray, DCTAB, ACTAB, QTAB);
save('jpegcodes.mat', 'dc_code', 'ac_code', 'img_height', 'img_width');
    
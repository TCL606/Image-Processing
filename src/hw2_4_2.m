clear all; close all; clc;
load("../图像处理所需资源/hall.mat");
[height, width] = size(hall_gray);
hall_part = double(hall_gray(1: height / 4, 1: width / 4)) - 128;
dct_mine = DCT2(hall_part);
dct_matlab = dct2(hall_part);
delta = sum((dct_mine - dct_matlab).^2, 'all') / size(dct_mine, 1) / size(dct_mine, 2);
disp(delta);

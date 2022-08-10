clear all; close all; clc;
load("../图像处理所需资源/hall.mat");
[height, width] = size(hall_gray);
hall_part = double(hall_gray(1: height / 4, 1: width / 4));

hall_direct = hall_part - 128;
maphall_1 = dct2(hall_direct);

[part_h, part_w] = size(hall_part);
DC_128 = dct2(zeros(part_h, part_w) + 128);
maphall_2 = dct2(hall_part);
maphall_2(1, 1) = maphall_2(1, 1) - DC_128(1, 1);
delta = sum((maphall_1 - maphall_2).^2, 'all');

subplot(1, 2, 1);
imshow(rescale(hall_direct));
hall_transform = idct2(maphall_2);
subplot(1, 2, 2);
imshow(rescale(hall_transform));
disp(delta);

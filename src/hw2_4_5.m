clear all; close all; clc;
load("../图像处理所需资源/hall.mat");
x = [1, -1];
y = [1];
freqz(x, y);

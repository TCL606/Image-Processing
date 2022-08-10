clear all, close all, clc;
load('../图像处理所需资源/hall.mat');
size_pic = size(hall_gray);
height = size_pic(1);
width = size_pic(2);
radius = min(height, width) / 2;

idx = zeros([size_pic, 2]);
for i = 1: 1: height
    for j = 1: 1: width
        idx(i, j, 1) = i;
        idx(i, j, 2) = j;
    end
end
circle_idx = ((idx(:, :, 1) - (height + 1) / 2) .^ 2 + (idx(:, :, 2) - (width + 1) / 2) .^ 2 <= (1.02 * radius) ^ 2 & ...
              (idx(:, :, 1) - (height + 1) / 2) .^ 2 + (idx(:, :, 2) - (width + 1) / 2) .^ 2 >= (0.98 * radius) ^ 2);
circle = hall_color;
for i = 1: 1: height
    for j = 1: 1: width
        if circle_idx(i, j)
            circle(i, j, 1) = 255;
            circle(i, j, 2) = 0;
            circle(i, j, 3) = 0;
        end
    end
end

subplot(1, 2, 1);
imshow(circle);
imwrite(circle, 'hw_3_2_circle.jpg');

chessboard = hall_color;
for i = 1: 1: 8
    for j = 1: 1: 8
        if mod(i, 2) == 1
            if mod((i - 1) * 8 + j - 1, 2) == 1
                chessboard((i - 1) * height / 8 + 1: i * height / 8, (j - 1) * width / 8 + 1: j * width / 8, 1) = 0;
                chessboard((i - 1) * height / 8 + 1: i * height / 8, (j - 1) * width / 8 + 1: j * width / 8, 2) = 0;
                chessboard((i - 1) * height / 8 + 1: i * height / 8, (j - 1) * width / 8 + 1: j * width / 8, 3) = 0;
            end
        else 
            if mod((i - 1) * 8 + j - 1, 2) == 0
                chessboard((i - 1) * height / 8 + 1: i * height / 8, (j - 1) * width / 8 + 1: j * width / 8, 1) = 0;
                chessboard((i - 1) * height / 8 + 1: i * height / 8, (j - 1) * width / 8 + 1: j * width / 8, 2) = 0;
                chessboard((i - 1) * height / 8 + 1: i * height / 8, (j - 1) * width / 8 + 1: j * width / 8, 3) = 0;
            end
        end
    end
end
subplot(1, 2, 2);
imshow(chessboard);
imwrite(chessboard, 'hw_3_2_chessboard.jpg');

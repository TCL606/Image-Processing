clear all; close all; clc;
faces_num = 33;
L = 3;
fold_path = "../图像处理所需资源/Faces";
face_feature = train_face(fold_path, faces_num, L);
img = imread("../图像处理所需资源/test1.png");
row_width = 20;
col_width = 20;
step = 5;
similarity_threshold = 0.503;
area_threshold = 0.01;
least_face_area = 1200;

img_rot = imrotate(img, -90);
[img_rot, ~] = DetectFace(img_rot, face_feature, L, similarity_threshold, area_threshold, row_width, col_width, step, least_face_area);
figure(1);
imshow(img_rot);
title('rotate 90^o');

img_dbw = imresize(img, [size(img, 1), 2 * size(img, 2)]);
[img_dbw, ~] = DetectFace(img_dbw, face_feature, L, similarity_threshold, area_threshold, row_width, col_width, step, least_face_area);
figure(2);
imshow(img_dbw);
title('double width');

img_adj = imadjust(img, [.1, .9]);
[img_adj, ~] = DetectFace(img_adj, face_feature, L, similarity_threshold, area_threshold, row_width, col_width, step, least_face_area);
figure(3);
imshow(img_adj);
title('adjust color');

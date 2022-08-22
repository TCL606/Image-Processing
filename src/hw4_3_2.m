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
least_face_area = 1000;
[img_3, faces_num_3] = DetectFace(img, face_feature, L, similarity_threshold, area_threshold, row_width, col_width, step, least_face_area);
subplot(3, 1, 1)
imshow(img_3);
title('L=3');

L = 4;
face_feature = train_face(fold_path, faces_num, L);
row_width = 20;
col_width = 20;
step = 5;
similarity_threshold = 0.603;
area_threshold = 0.01;
least_face_area = 1000;
[img_4, faces_num_4] = DetectFace(img, face_feature, L, similarity_threshold, area_threshold, row_width, col_width, step, least_face_area);
subplot(3, 1, 2)
imshow(img_4);
title('L=4');

L = 5;
face_feature = train_face(fold_path, faces_num, L);
row_width = 20;
col_width = 20;
step = 5;
similarity_threshold = 0.75;
area_threshold = 0.01;
least_face_area = 1000;
[img_5, faces_num_5] = DetectFace(img, face_feature, L, similarity_threshold, area_threshold, row_width, col_width, step, least_face_area);
subplot(3, 1, 3)
imshow(img_5);
title('L=5');

clear all; close all; clc;
faces_num = 33;
face_feature_3 = train_face("../图像处理所需资源/Faces", faces_num, 3);
face_feature_4 = train_face("../图像处理所需资源/Faces", faces_num, 4);
face_feature_5 = train_face("../图像处理所需资源/Faces", faces_num, 5);

subplot(3, 1, 1);
plot([0 : 1 : 2^(3 * 3) - 1], face_feature_3);
title("L=3");
subplot(3, 1, 2);
plot([0 : 1 : 2^(3 * 4) - 1], face_feature_4);
title("L=4");
subplot(3, 1, 3);
plot([0 : 1 : 2^(3 * 5) - 1], face_feature_5);
title("L=5");


function face_feature = train_face(faces_path, faces_num, L)
    face_feature = zeros([1, 2^(3 * L)]);
    for i = 1: 1: faces_num
        face_temp = imread(faces_path + "/" + string(i) + ".bmp");
        feature_temp = get_face_feat(face_temp, L);
        face_feature = face_feature + feature_temp;
    end
    face_feature = face_feature / faces_num;
end


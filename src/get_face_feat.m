function face_feature = get_face_feat(faces_path, faces_num, L)
    face_feature = zeros([1, 2^(3 * L)]);
    for i = 1: 1: faces_num
        face_temp = double(imread(faces_path + "/" + string(i) + ".bmp"));
        feature_temp = zeros([1, 2^(3 * L)]);
        for j = 1: 1: size(face_temp, 1)
           for k = 1: 1: size(face_temp, 2) 
            r = floor(face_temp(j, k, 1) * 2^(L - 8));
            g = floor(face_temp(j, k, 2) * 2^(L - 8));
            b = floor(face_temp(j, k, 3) * 2^(L - 8));
            n = r * 2^(2 * L) + g * 2^L + b;
            feature_temp(n + 1) = feature_temp(n + 1) + 1;
           end
        end
        face_feature = face_feature + feature_temp / size(face_temp, 1) / size(face_temp, 2);
    end
    face_feature = face_feature / faces_num;
end


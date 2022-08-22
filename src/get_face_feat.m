function feature_temp = get_face_feat(face, L)
    face_temp = double(face);
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
    feature_temp = feature_temp / size(face_temp, 1) / size(face_temp, 2);
end


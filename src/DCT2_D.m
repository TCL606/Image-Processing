function D_mat = DCT2_D(input_dim)
    row = linspace(0, input_dim - 1, input_dim)';
    col = linspace(1, input_dim * 2 - 1, input_dim);
    cos_mat = cos(row * col * pi / (2 * input_dim));
    cos_mat(1, :) = cos_mat(1, :) / sqrt(2);
    D_mat = sqrt(2 / input_dim) * cos_mat;
end


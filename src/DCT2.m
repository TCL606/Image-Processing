function [dct_coef] = DCT2(input_mat)
    [height, width] = size(input_mat);
    dct_coef = DCT2_D(height) * double(input_mat) * DCT2_D(width)';
end


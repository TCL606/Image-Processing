function [dc_code, ac_code, img_height, img_width] = Compress(img, DCTAB, ACTAB, QTAB)
    hall_pre = double(img) - 128;
    hall_quan = blockproc(hall_pre, [8, 8], @(mat)(zig_zag(round(dct2(mat.data) ./ QTAB))));
    [height, width] = size(hall_quan);
    quan_mat = zeros([64, height * width / 64]);
    for i = 0: 1: height / 64 - 1
        for j = 1: 1: width
            quan_mat(:, i * width + j) = hall_quan(i * 64 + 1: (i + 1) * 64, j);
        end
    end
    dc_cof = quan_mat(1, :)';
    dc_diff = [dc_cof(1); dc_cof(1: end - 1) - dc_cof(2: end)];
    dc_category = min(ceil(log2(abs(dc_diff) + 1)), 11);
    dc_code = [];
    for i = 1: 1: length(dc_diff)
        cat_temp = DCTAB(dc_category(i) + 1, 2: DCTAB(dc_category(i) + 1, 1) + 1)';
        if dc_diff(i) ~= 0
            mag_temp = dec2bin(abs(dc_diff(i)))' - '0';
            if dc_diff(i) < 0
                mag_temp = ~mag_temp;
            end
        else
            mag_temp = [];
        end
        dc_code = [dc_code; cat_temp; mag_temp];
    end

    ac_cof = quan_mat(2: end, :);
    ac_size = min(ceil(log2(abs(ac_cof) + 1)), 10);
    ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1]';
    EOB = [1, 0, 1, 0]';
    [ac_h, ac_w] = size(ac_size);
    ac_code = [];
    for i = 1: 1: ac_w
        run = 0;
        for j = 1: 1: ac_h
            if ac_size(j, i) == 0
                run = run + 1;
            else
                run_epoch = floor(run / 16);
                run_mod = mod(run, 16);
                run = 0;
                while run_epoch > 0
                    ac_code = [ac_code; ZRL];
                    run_epoch = run_epoch - 1;
                end
                size_temp = ACTAB(run_mod * 10 + ac_size(j, i), 4: ACTAB(run_mod * 10 + ac_size(j, i), 3) + 3)';
                amp_temp = dec2bin(abs(ac_cof(j, i)))' - '0';
                if ac_cof(j, i) < 0
                    amp_temp = ~amp_temp;
                end
                ac_code = [ac_code; size_temp; amp_temp];
            end
        end
        ac_code = [ac_code; EOB];
    end

    [img_height, img_width] = size(img);
end
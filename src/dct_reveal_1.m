function [reveal_info, reveal_img] = dct_reveal_1(dc_code, ac_code, img_height, img_width, DCTAB, ACTAB, QTAB)
    dc_diff = zeros([img_height * img_width / 64, 1]);
    last_idx = 1;
    cnt = 1;
    i = 1;
    while i <= length(dc_code)
        for j = 1: 1: size(DCTAB, 1)
            if isequal(dc_code(last_idx: i)', DCTAB(j, 2: DCTAB(j, 1) + 1))
                if j - 1 ~= 0
                    mag_temp = dc_code(i + 1: i + j - 1)';
                    if mag_temp(1) == 1
                        dc_diff(cnt) = bin2dec(char(mag_temp + '0'));
                    else
                        dc_diff(cnt) = -bin2dec(char(~mag_temp + '0'));
                    end
                end
                last_idx = i + j;
                i = i + j;
                cnt = cnt + 1;
                break;
            end
        end
        i = i + 1;
    end
    dc_cof = zeros(size(dc_diff));
    dc_cof(1) = dc_diff(1);
    for i = 2: 1: size(dc_cof, 1)
        dc_cof(i) = dc_cof(i - 1) - dc_diff(i);
    end

    ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1]';
    EOB = [1, 0, 1, 0]';
    ac_cof = zeros([63, img_height * img_width / 64]);
    i = 1;
    last_idx = 1;
    row_cnt = 1;
    col_cnt = 1;
    while i <= length(ac_code)
        if isequal(ac_code(last_idx: i), EOB)
            col_cnt = col_cnt + 1;
            row_cnt = 1;
            last_idx = i + 1;
            i = last_idx;
        elseif isequal(ac_code(last_idx: i), ZRL)
            row_cnt = row_cnt + 16;
            last_idx = i + 1;
            i = last_idx;
        else
            for j = 1: 1: size(ACTAB, 1)
                if isequal(ac_code(last_idx: i)', ACTAB(j, 4: ACTAB(j, 3) + 3))
                    row_cnt = row_cnt + ACTAB(j, 1);
                    amp_temp = ac_code(i + 1: i + ACTAB(j, 2))';
                    if amp_temp(1) == 1
                        ac_cof(row_cnt, col_cnt) = bin2dec(char(amp_temp + '0'));
                    else
                        ac_cof(row_cnt, col_cnt) = -bin2dec(char(~amp_temp + '0'));
                    end
                    row_cnt = row_cnt + 1;
                    last_idx = i + ACTAB(j, 2) + 1;
                    i = last_idx;
                    break;
                end
            end
        end
        i = i + 1;
    end
    whole_cof = [dc_cof'; ac_cof];
    reveal_info = bitand(int32(whole_cof), int32(ones(size(whole_cof))));
    hall_quan = zeros([img_height * 8, img_width / 8]);
    for i = 0: 1: img_height / 8 - 1
        hall_quan(i * 64 + 1: (i + 1) * 64, :) = whole_cof(:, i * img_width / 8 + 1: (i + 1) * img_width / 8);
    end
    reveal_img = uint8(blockproc(hall_quan, [64, 1], @(mat)(idct2(inv_zig_zag(mat.data) .* QTAB))) + 128);
end


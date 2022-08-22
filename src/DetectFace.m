function [img, faces_num] = DetectFace(img, face_feature, L, similarity_threshold, area_threshold, row_width, col_width, step, least_face_area)
    x_less = [];
    y_large = [];
    i = row_width;
    while i <= size(img, 1)
        j = col_width;
        while j <= size(img, 2)
            feat_temp = get_face_feat(img(i - row_width + 1: i, j - col_width + 1: j, :), L);
            dist = 1 - sum(sqrt(feat_temp .* face_feature));
            if dist < similarity_threshold
                x_less = [x_less, i - row_width + 1];
                y_large = [y_large, j];
            end
            j = j + step;
        end
        i = i + step;
    end
    x_large = x_less + (row_width - 1);
    y_less = y_large - (col_width - 1);

    for i = 1: 1: length(x_less)
        if x_less(i) ~= -1
            for j = i + 1: 1: length(x_less)
                if j ~= i && x_less(j) ~= -1
                    if x_less(i) == x_less(j)
                        if y_less(j) <= y_large(i) + col_width && y_less(j) >= y_less(i)
                            y_large(i) = y_large(j);
                            x_large(i) = max(x_large(i), x_large(j));
                            x_less(j) = -1;
                        end
                    end
                    if y_less(i) == y_less(j)
                        if x_less(j) <= x_large(i) + row_width && x_less(j) >= x_less(i)
                            x_large(i) = x_large(j);
                            y_large(i) = max(y_large(i), y_large(j));
                            x_less(j) = -1;
                        end
                    end
                end
            end
        end
    end

    face_idx_1 = x_less ~= -1;
    x_less = x_less(face_idx_1);
    x_large = x_large(face_idx_1);
    y_less = y_less(face_idx_1);
    y_large = y_large(face_idx_1);
    for i = 1: 1: length(x_less)
        if x_less(i) ~= -1
            area_i = (x_large(i) - x_less(i)) * (y_large(i) - y_less(i));
            for j = 1: 1: length(x_less)
                if j ~= i && x_less(j) ~= -1 
                    if x_less(j) <= x_large(i) && x_less(j) >= x_less(i) && y_less(j) <= y_large(i) && y_less(j) >= y_less(i) 
                        area_overlap = (min(x_large(i), x_large(j)) - x_less(j)) * (min(y_large(i), y_large(j)) - y_less(j));
                        if area_overlap / area_i >= area_threshold
                            x_less(j) = -1;
                        end
                    elseif x_less(j) >= x_less(i) && x_less(j) <= x_large(i) && y_less(i) <= y_less(j) && y_large(i) >= y_large(j)
                        area_overlap = (min(x_large(i), x_large(j)) - x_less(j)) * (y_large(j) - y_less(j));
                        if area_overlap / area_i >= area_threshold
                            x_less(j) = -1;
                        end
                    elseif y_less(j) >= y_less(i) && y_less(j) <= y_large(i) && x_less(i) <= x_less(j) && x_large(i) >= x_large(j)
                        area_overlap = (min(y_large(i), y_large(j)) - y_less(j)) * (x_large(j) - x_less(j));
                        if area_overlap / area_i >= area_threshold
                            x_less(j) = -1;
                        end
                    elseif x_large(j) >= x_less(i) && x_large(j) <= x_large(i) && y_less(i) <= y_less(j) && y_large(i) >= y_large(j)
                        area_overlap = (x_large(j) - max(x_less(i), x_less(j))) * (y_large(j) - y_less(j));
                        if area_overlap / area_i >= area_threshold
                            x_less(j) = -1;
                        end
                    elseif y_large(j) >= y_less(i) && y_large(j) <= y_large(i) && x_less(i) <= x_less(j) && x_large(i) >= x_large(j)
                        area_overlap = (y_large(j) - max(y_less(i), y_less(j))) * (x_large(j) - x_less(j));
                        if area_overlap / area_i >= area_threshold
                            x_less(j) = -1;
                        end
                    elseif x_less(j) >= x_less(i) && x_large(j) <= x_large(i) && y_less(i) >= y_less(j) && y_large(i) <= y_large(j)
                        area_overlap = (x_large(j) - x_less(j)) * (y_large(i) - y_less(i));      
                        if area_overlap / area_i >= area_threshold
                            x_less(j) = -1;
                        end
                    end        
                end
            end
        end
    end
    
    for i = 1: 1: length(x_less)
        if x_less(i) ~= -1
            if (x_large(i) - x_less(i)) * (y_large(i) - y_less(i)) <= least_face_area
                x_less(i) = -1;
            end
        end
    end

    faces_num = sum(x_less ~= -1);

    rect_face = logical(zeros(size(img)));
    edge = 1;
    for i = 1 : 1 : length(x_less)
        if x_less(i) ~= -1
            rect_face(max(x_less(i) - edge, 1): x_less(i) + edge, y_less(i) : y_large(i), 1) = true;
            rect_face(x_large(i) - edge: min(size(img, 1), x_large(i) + edge), y_less(i) : y_large(i), 1) = true;
            rect_face(x_less(i): x_large(i), max(1, y_less(i) - edge): y_less(i) + edge, 1) = true;
            rect_face(x_less(i): x_large(i), y_large(i) - edge: min(size(img, 2), y_large(i) + edge), 1) = true;
        end
    end
    img(rect_face) = uint8(255);
end


function [valid_layer,layer] = rgb_segment(im, threshold_val)
    im_filt = imbilatfilt(im);

    [height, width, ~] = size(im);

    layer = reshape(1:height*width, height, width);
    layer_copy = layer;
    
    for w = 1:width
        for h = 1:height
            nabh_h = [h+1, h, h-1, h+1, h-1, h+1, h, h-1];
            nabh_w = [w-1, w-1, w-1, w, w, w+1, w+1, w+1];
            bound_check = ((nabh_h > 0)&(nabh_h <= height))...
                          & ((nabh_w > 0)&(nabh_w <= width));

            num_of_nabh = length(nabh_h);
            for i = 1:num_of_nabh
                if bound_check(i) ~= 0
                    ecl_dist = norm(reshape(double(im_filt(h, w, :)), 3, 1)...
                                    - reshape(double(im_filt(nabh_h(i), nabh_w(i), :)), 3, 1));

                    if ecl_dist < threshold_val
                        layer(nabh_h(i), nabh_w(i)) = layer(h, w);
                    end
                end
            end
        end
    end

    %layer = medfilt2(layer, [3 3], 'symmetric');

    valid_layer = find(layer == layer_copy);
end


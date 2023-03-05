function [recovered_bits] = recover_modulated_bits_16PSK(modulated_noisy_bits)
    import reference_points_16PSK
    import find_nearest_16PSK_point
    load('16PSK_reference_points.mat')

    num_bits_modulated = size(modulated_noisy_bits, 2);
    num_bits_to_recover = num_bits_modulated*4;
    recovered_bits = zeros(1, num_bits_to_recover);
    
    for i=1:num_bits_modulated
        closest_16PSK_point_index = find_nearest_16PSK_point(modulated_noisy_bits(i));
        closest_16PSK_point_bits = inverse_reference_16PSK_points(closest_16PSK_point_index, :);
        recovered_bits((1+(i-1)*4):(4*i)) = closest_16PSK_point_bits;
    end
end
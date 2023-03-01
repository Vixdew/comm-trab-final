function [modulated_bits, original_bits] = modulate_bits_16PSK(num_bits)
    import bit2int_4bits
    import possible_values
    load('16PSK_reference_points.mat')
    
    bits = int8(randi(2, 1, num_bits) - 1);
    
    num_bits_modulated = num_bits/4;
    modulated_bits = zeros(1, num_bits_modulated);
    
    %Checar tabela #TODO 
    
    
    
    
    for j=1:num_bits_modulated
        bits_to_be_modulated = bits((1+(j-1)*4):(4*j));
        bits_modulated_complex = reference_16PSK_points(bit2int_4bits(bits_to_be_modulated)+1);
        modulated_bits(j) = bits_modulated_complex;
    end
    
    original_bits = bits;
end
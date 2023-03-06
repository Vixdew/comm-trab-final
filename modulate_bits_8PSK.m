%Função serve para transformar sequência de bits de entrada em uma
%sequência de números complexos, representando os bits em pontos 8PSK a
%serem transmitidos. Os três bits são transformados em um número
%decimal+1, que então é usado para acessar uma matriz que diz qual é o
%index que representa aquela sequência de bits na matriz
%reference_8PSK_points. Assim, faz-se a tradução de 3 bits em um número
%complexo.

function [modulated_bits] = modulate_bits_8PSK(original_bits)
    import bit2int_3bits
    import reference_points_8PSK
    load('8PSK_reference_points.mat')
    
    num_bits_modulated = size(original_bits,2)/3;
    modulated_bits = zeros(1, num_bits_modulated);
    
    for j=1:num_bits_modulated
        bits_to_be_modulated = original_bits((1+(j-1)*3):(3*j));
        v_8PSK_reference_index = binary_to_8PSK_points_index(bit2int_3bits(bits_to_be_modulated)+1);
        bits_modulated_complex = reference_8PSK_points(v_8PSK_reference_index);
        modulated_bits(j) = bits_modulated_complex;
    end
end
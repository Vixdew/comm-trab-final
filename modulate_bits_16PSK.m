%Fun��o serve para transformar sequ�ncia de bits de entrada em uma
%sequ�ncia de n�meros complexos, representando os bits em pontos 16PSK a
%serem transmitidos. Os quatro bits s�o transformados em um n�mero
%decimal+1, que ent�o � usado para acessar uma matriz que diz qual � o
%index que representa aquela sequ�ncia de bits na matriz
%reference_16PSK_points. Assim, faz-se a tradu��o de 4 bits em um n�mero
%complexo.

function [modulated_bits] = modulate_bits_16PSK(original_bits)
    import bit2int_4bits
    import reference_points_16PSK
    load('16PSK_reference_points.mat')
    
    num_bits_modulated = size(original_bits,2)/4;
    modulated_bits = zeros(1, num_bits_modulated);
    
    for j=1:num_bits_modulated
        bits_to_be_modulated = original_bits((1+(j-1)*4):(4*j));
        v_16PSK_reference_index = binary_to_16PSK_points_index(bit2int_4bits(bits_to_be_modulated)+1);
        bits_modulated_complex = reference_16PSK_points(v_16PSK_reference_index);
        modulated_bits(j) = bits_modulated_complex;
    end
end
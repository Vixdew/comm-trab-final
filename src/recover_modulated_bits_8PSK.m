%Esta fun��o serve para, � partir de uma sequ�ncia de bits modulados
%ruidosos, encontrar qual � o ponto 16PSK que melhor o aproxima via a 
%fun��o find_nearest_8PSK_point. Esta fun��o retornar� um index que ser�
%usado para reverter a modula��o via um acesso a matriz
%inverse_reference_8PSK_points, que traduzir� a aproxima��o do ponto
%ruidoso em uma sequ�ncia de 3 bits. A fun��o itera sobre os bits de
%entrada at� percorrer todo ele.

%Fun��o presume que modulated_noisy_bits tenha # de bits divis�vel por 3.

function [recovered_bits] = recover_modulated_bits_8PSK(modulated_noisy_bits)
    import reference_points_8PSK
    import find_nearest_8PSK_point
    load('8PSK_reference_points.mat')

    num_bits_modulated = size(modulated_noisy_bits, 2);
    num_bits_to_recover = num_bits_modulated*3;
    recovered_bits = zeros(1, num_bits_to_recover);
    
    for i=1:num_bits_modulated
        closest_8PSK_point_index = find_nearest_8PSK_point(modulated_noisy_bits(i));
        closest_8PSK_point_bits = inverse_reference_8PSK_points(closest_8PSK_point_index, :);
        recovered_bits((1+(i-1)*3):(3*i)) = closest_8PSK_point_bits;
    end
end
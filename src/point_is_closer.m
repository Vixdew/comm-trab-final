%Fun��o booleana. Serve para determinar se a dist�ncia entre um n�mero
%complexo ruidoso e um determinado ponto de refer�ncia 16PSK ou 8PSK �
%menor que current_min_distance.

function [isCloser] = point_is_closer(noisy_point, reference_point, current_min_distance)
    import get_absolute_distance_between_complex_points
    
    isCloser = 0;
    if(get_absolute_distance_between_complex_points(...
        noisy_point, ...
        reference_point) < current_min_distance)
        
        isCloser = 1;
    end
end
%Função serve para encontrar o ponto 8PSK que melhor aproxima um número
%complexo ruidoso. Itera sobre todos os oito possíveis valores e retorna o
%index do ponto que melhor aproxima esse número complexo. 

%Este ponto será posteriormente usado em
%inverse_reference_8PSK_points para obter a representação em bits de tal
%aproximação.

function [result] = find_nearest_8PSK_point(noisy_point)
    import reference_points_8PSK
    import point_is_closer
    import get_absolute_distance_between_complex_points
    
    load('8PSK_reference_points.mat')
    
    result_temp = reference_8PSK_points - noisy_point;
    
    min_distance_so_far = 1000;
    index_of_said_distance = 1;
    
    for i=1:8
        if(point_is_closer(...
            result_temp(i),...
            noisy_point,...
            min_distance_so_far))   % Se o ponto 8PSK atual melhor aproxima o ponto ruidoso, atualizar a melhor aproximação.
            
            min_distance_so_far = get_absolute_distance_between_complex_points(...
                noisy_point, ...
                result_temp(i));
            
            index_of_said_distance = i;
        end
    end
    
    result = index_of_said_distance;
end
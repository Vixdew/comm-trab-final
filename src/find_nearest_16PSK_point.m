%Função serve para encontrar o ponto 16PSK que melhor aproxima um número
%complexo ruidoso. Itera sobre todos os dezesseis possíveis valores e retorna o
%index do ponto que melhor aproxima esse número complexo. 

%Este ponto será posteriormente usado em
%inverse_reference_16PSK_points para obter a representação em bits de tal
%aproximação.

function [result] = find_nearest_16PSK_point(noisy_point)
    import reference_points_16PSK
    import point_is_closer
    import get_absolute_distance_between_complex_points
    
    load('16PSK_reference_points.mat')
    
    result_temp = reference_16PSK_points - noisy_point;
    
    min_distance_so_far = 1000;
    index_of_said_distance = 1;
    
    for i=1:16
        if(point_is_closer(...
            result_temp(i),...
            noisy_point,...
            min_distance_so_far))   % Se o ponto 16PSK atual melhor aproxima o ponto ruidoso, atualizar a melhor aproximação.
            
            min_distance_so_far = get_absolute_distance_between_complex_points(...
                noisy_point, ...
                result_temp(i));
            
            index_of_said_distance = i;
        end
    end
    
    result = index_of_said_distance;
end
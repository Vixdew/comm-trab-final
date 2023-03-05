one_eigth = sqrt(2)/2;

%Vetor abaixo serve para, em conjunto com bit2int_3bits, transformar um
%vetor de 3 bits em um index com o qual acessar reference_8PSK_points para
%transformar uma sequência de 3 bits em um número complexo segundo o código
%de Gray.

binary_to_8PSK_points_index = [ %Se os bits a serem enviados são
    1               %0 (binario 0 + 1), então deve acessar index 1 em reference_16PSK_points
    ,2              %1 (binario 1 + 1), então acessar index 2
    ,4              %2, então deve acessar index 4
    ,3              %etc
    ,8
    ,7
    ,5
    ,6]

reference_8PSK_points = [                             %Representation in bits (using Gray's Code)
    complex(1, 0)                                       %000
    ,complex(one_eigth, one_eigth)                      %001
    ,complex(0, 1)                                      %011
    ,complex(-one_eigth, one_eigth)                     %010
    ,complex(-1, 0)                                     %110
    ,complex(-one_eigth, - one_eigth)                   %111
    ,complex(0, - 1)                                    %101
    ,complex(one_eigth, - one_eigth)]                   %100


inverse_reference_8PSK_points = [
     [0 0 0]
    ,[0 0 1]
    ,[0 1 1]
    ,[0 1 0]
    ,[1 1 0]
    ,[1 1 1]
    ,[1 0 1]
    ,[1 0 0]]

save('8PSK_reference_points.mat', 'reference_8PSK_points', 'inverse_reference_8PSK_points', 'binary_to_8PSK_points_index')
%Este arquivo serve para armazenar em um só lugar as matrizes necessárias
%para transformar uma sequência de 3 bits em um ponto 8PSK, segundo a
%codificação de Gray, e fazer a transformação inversa.

one_eigth = sqrt(2)/2;

%Vetor abaixo serve para auxiliar a transformação da sequência de bits em
%um ponto complexo. Após a sequência de bits ser transformada em um número
%inteiro via bit2int_4bits, este número+1 será usado para indexar a matriz
%abaixo. À partir dessa indexação, consegue-se o index do valor complexo
%equivalente àquela sequência de bits na matriz reference_16PSK_points.

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

%A matriz abaixo é usada após saber-se qual dos pontos abaixo melhor
%aproxima um número complexo recebido. Após saber-se isso via a função
%find_nearest_8PSK_point, se indexa essa matriz para recuperar o conteúdo
%em bits.
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
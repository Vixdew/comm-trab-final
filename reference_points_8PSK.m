%Este arquivo serve para armazenar em um s� lugar as matrizes necess�rias
%para transformar uma sequ�ncia de 3 bits em um ponto 8PSK, segundo a
%codifica��o de Gray, e fazer a transforma��o inversa.

one_eigth = sqrt(2)/2;

%Vetor abaixo serve para auxiliar a transforma��o da sequ�ncia de bits em
%um ponto complexo. Ap�s a sequ�ncia de bits ser transformada em um n�mero
%inteiro via bit2int_4bits, este n�mero+1 ser� usado para indexar a matriz
%abaixo. � partir dessa indexa��o, consegue-se o index do valor complexo
%equivalente �quela sequ�ncia de bits na matriz reference_16PSK_points.

binary_to_8PSK_points_index = [ %Se os bits a serem enviados s�o
    1               %0 (binario 0 + 1), ent�o deve acessar index 1 em reference_16PSK_points
    ,2              %1 (binario 1 + 1), ent�o acessar index 2
    ,4              %2, ent�o deve acessar index 4
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

%A matriz abaixo � usada ap�s saber-se qual dos pontos abaixo melhor
%aproxima um n�mero complexo recebido. Ap�s saber-se isso via a fun��o
%find_nearest_8PSK_point, se indexa essa matriz para recuperar o conte�do
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
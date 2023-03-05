one_sixteenth_pos = sqrt(2+sqrt(2))/2;
one_sixteenth_neg = sqrt(2-sqrt(2))/2;
one_eigth = sqrt(2)/2;

%Vetor abaixo serve para, em conjunto com bit2int_4bits, transformar um
%vetor de 4 bits em um index com o qual acessar reference_16PSK_points para
%transformar uma sequ�ncia de 4 bits em um n�mero complexo segundo o c�digo
%de Gray.

binary_to_16PSK_points_index = [ %Se os bits a serem enviados s�o
    1               %0 (binario 0 + 1), ent�o deve acessar index 1 em reference_16PSK_points
    ,16             %1 (binario 1 + 1), ent�o acessar index 16
    ,14             %2, ent�o deve acessar index 14
    ,15             %etc
    ,10
    ,11
    ,13
    ,12
    ,2
    ,3
    ,5
    ,4
    ,9
    ,8
    ,6
    ,7]

reference_16PSK_points = [                             %Representation in bits (using Gray's Code)
    complex(1, 0)                                       %0000
    ,complex(one_sixteenth_pos, one_sixteenth_neg)      %1000
    ,complex(one_eigth, one_eigth)                      %1001
    ,complex(one_sixteenth_neg, one_sixteenth_pos)      %1011
    ,complex(0, 1)                                      %1010
    ,complex(-one_sixteenth_neg, one_sixteenth_pos)     %1110
    ,complex(-one_eigth, one_eigth)                     %1111
    ,complex(-one_sixteenth_pos, one_sixteenth_neg)     %1101
    ,complex(-1, 0)                                     %1100
    ,complex(-one_sixteenth_pos, - one_sixteenth_neg)   %0100
    ,complex(-one_eigth, - one_eigth)                   %0101
    ,complex(-one_sixteenth_neg, - one_sixteenth_pos)   %0111
    ,complex(0, - 1)                                    %0110
    ,complex(one_sixteenth_neg, - one_sixteenth_pos)    %0010
    ,complex(one_eigth, - one_eigth)                    %0011
    ,complex(one_sixteenth_pos, - one_sixteenth_neg)];  %0001

inverse_reference_16PSK_points = [
     [0 0 0 0]
    ,[1 0 0 0]
    ,[1 0 0 1]
    ,[1 0 1 1]
    ,[1 0 1 0]
    ,[1 1 1 0]
    ,[1 1 1 1]
    ,[1 1 0 1]
    ,[1 1 0 0]
    ,[0 1 0 0]
    ,[0 1 0 1]
    ,[0 1 1 1]
    ,[0 1 1 0]
    ,[0 0 1 0]
    ,[0 0 1 1]
    ,[0 0 0 1]]

save('16PSK_reference_points.mat', 'reference_16PSK_points', 'inverse_reference_16PSK_points', 'binary_to_16PSK_points_index')
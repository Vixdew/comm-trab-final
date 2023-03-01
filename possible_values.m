one_sixteenth_pos = sqrt(2+sqrt(2))/2;
one_sixteenth_neg = sqrt(2-sqrt(2))/2;
one_eigth = sqrt(2)/2;

reference_16PSK_points = [                             %Representation in bits
    complex(1, 0)                                     %0000
    ,complex(one_sixteenth_pos, one_sixteenth_neg)       %0001
    ,complex(one_eigth, one_eigth)                      %0010
    ,complex(one_sixteenth_neg, one_sixteenth_pos)      %0011
    ,complex(0, 1)                                     %0100
    ,complex(-one_sixteenth_neg, one_sixteenth_pos)     %0101
    ,complex(-one_eigth, one_eigth)                     %0110
    ,complex(-one_sixteenth_pos, one_sixteenth_neg)     %0111
    ,complex(-1, 0)                                    %1000
    ,complex(-one_sixteenth_pos, - one_sixteenth_neg)     %1001
    ,complex(-one_eigth, - one_eigth)                     %1010
    ,complex(-one_sixteenth_neg, - one_sixteenth_pos)     %1011
    ,complex(0, - 1)                                     %1100
    ,complex(one_sixteenth_neg, - one_sixteenth_pos)      %1101
    ,complex(one_eigth, - one_eigth)                      %1110
    ,complex(one_sixteenth_pos, - one_sixteenth_neg)];    %1111

inverse_reference_16PSK_points = [
     [0 0 0 0]
    ,[0 0 0 1]
    ,[0 0 1 0]
    ,[0 0 1 1]
    ,[0 1 0 0]
    ,[0 1 0 1]
    ,[0 1 1 0]
    ,[0 1 1 1]
    ,[1 0 0 0]
    ,[1 0 0 1]
    ,[1 0 1 0]
    ,[1 0 1 1]
    ,[1 1 0 0]
    ,[1 1 0 1]
    ,[1 1 1 0]
    ,[1 1 1 1]]

save('16PSK_reference_points.mat', 'reference_16PSK_points', 'inverse_reference_16PSK_points')
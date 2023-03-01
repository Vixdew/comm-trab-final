function [result] = bit2int_4bits(input)
    result = input(1)*8+input(2)*4+input(3)*2+input(4)*1;
end
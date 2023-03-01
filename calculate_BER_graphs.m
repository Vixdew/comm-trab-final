function [result] = calculate_BER_graphs()
    clear;
    close;


    import modulate_bits_16PSK
    import recover_modulated_bits_16PSK

    num_b = 1000000; %n�mero de bits a serem simulados
    %bits = complex(2*randi(2, 1, num_b)-3, 0); %bits aleat�rios modulados em BPSK (parte real em 1 e -1)
    [bits_modulated, bits] = modulate_bits_16PSK(num_b);
    Eb_N0_dB = 0:1:17; %faixa de Eb/N0
    Eb_N0_lin = 4*10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
    ber = zeros(size(Eb_N0_lin)); %pr�-aloca��o do vetor de BER
    Eb = 0.25; % energia por bit para a modula��o BPSK utilizada

    NP = Eb ./ (Eb_N0_lin); %vetor de pot�ncias do ru�do
    NA = sqrt(NP); %vetor de amplitudes do ru�do

    for i = 1:length(Eb_N0_lin)
        %n = NA(i)*complex(randn(1, num_b), randn(1, num_b))*sqrt(0.5);
        n = NA(i)*complex(randn(1, num_b/4), randn(1, num_b/4))*sqrt(0.5); %vetor de ru�do complexo com desvio padr�o igual a uma posi��o do vetor NA
        %r = bits + n;
        r = bits_modulated + n; % vetor recebido
        %demod = sign(real(r)); % recupera a informa��o (sinal da parte real)
        demod = recover_modulated_bits_16PSK(r);
        i
        ber(i) = sum(bits ~= demod) / num_b; % contagem de erros e c�lculo do BER
    end
    
    result = ber

    %ber_theoretical = 0.25*erfc(sqrt(2*Eb_N0_lin)/sqrt(2)); %BER te�rico para compara��o
    ber_theoretical = (1/4)*erfc(sqrt(Eb_N0_lin)*sin(pi/16));
    semilogy(Eb_N0_dB, ber, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
    xlabel('Eb/N0 (dB)');
    ylabel('BER');
    legend('Simulado','Te�rico');
end
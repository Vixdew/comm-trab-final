function [result] = calculate_BER_graphs()
    clear;
    close;


    import modulate_bits_16PSK
    import modulate_bits_8PSK
    import recover_modulated_bits_16PSK
    import recover_modulated_bits_8PSK

    num_b = 1000200; %número de bits a serem simulados
    M_16PSK = 16;
    M_8PSK = 8;
    original_bits = int8(randi(2, 1, num_b) - 1);
    
    %Pega a representação octal dos polinomios geradores dos códigos
    %abaixo, usado na função poly2trellis
    octal_representation_of_generative_polynomials_M17 = [str2num(dec2base(bin2dec('11001'),8)), ...
                                                          str2num(dec2base(bin2dec('10111'),8))];
                                    
    octal_representation_of_generative_polynomials_TCH_HS = [str2num(dec2base(bin2dec('1101101'),8)), ...
                                                             str2num(dec2base(bin2dec('1010011'),8)), ...
                                                             str2num(dec2base(bin2dec('1011111'),8))];
                                                         
    octal_representation_of_generative_polynomials_ML_MANUAL = [str2num(dec2base(bin2dec('11111'),8)), ...
                                                                str2num(dec2base(bin2dec('11011'),8))];
                                                             
    octal_representation_of_feedback_polynomial_ML_MANUAL = str2num(dec2base(bin2dec('11111'),8));
    
    %Cria as trellis para codificar bits de acordo com os códigos
    %convolucionais definidos pelas representações octais.
    trellis_M17 = poly2trellis(5, octal_representation_of_generative_polynomials_M17);
    trellis_TCH_HS = poly2trellis(7, octal_representation_of_generative_polynomials_TCH_HS);
    trellis_ML_MANUAL = poly2trellis(5, octal_representation_of_generative_polynomials_ML_MANUAL, ...
                                     octal_representation_of_feedback_polynomial_ML_MANUAL);
                                 
    noise_potency_multiplier_M17 = 2 % Razão do código M17 é 1/2
    noise_potency_multiplier_TCH_HS = 3 % Razão do código é 1/3
    noise_potency_multiplier_ML_MANUAL = 2 % Razão do código é 1/2
   
    %Modula os bits de entrada, codificando-os antes de modular.
    %nocod = sem código convolucional
    %M17 = Padrão de transmissão de comunicação por rádio amadora em rádios M17
    %TCH_HS = Padrão usado para transmissão de voz, definido pelo GSM.
    %ML_MANUAL = Exemplo de codificação com feedback usada no manual do
    %matlab.
    bits_modulated_16PSK_nocod =    modulate_bits_16PSK(original_bits);
    bits_modulated_16PSK_M17 =      modulate_bits_16PSK(convenc(original_bits, trellis_M17));
    bits_modulated_16PSK_TCH_HS =   modulate_bits_16PSK(convenc(original_bits, trellis_TCH_HS));
    bits_modulated_16PSK_ML_MANUAL = modulate_bits_16PSK(convenc(original_bits, trellis_ML_MANUAL));
    
    bits_modulated_8PSK_nocod =    modulate_bits_8PSK(original_bits);
    bits_modulated_8PSK_M17 =      modulate_bits_8PSK(convenc(original_bits, trellis_M17));
    bits_modulated_8PSK_TCH_HS =   modulate_bits_8PSK(convenc(original_bits, trellis_TCH_HS));
    bits_modulated_8PSK_ML_MANUAL = modulate_bits_8PSK(convenc(original_bits, trellis_ML_MANUAL));
    
    
    %Pega o tamanho de cada vetor, usado posteriomente.
    len_16PSK_nocod = size(bits_modulated_16PSK_nocod, 2);
    len_16PSK_M17 = size(bits_modulated_16PSK_M17, 2);
    len_16PSK_TCH_HS = size(bits_modulated_16PSK_TCH_HS, 2);
    len_16PSK_ML_MANUAL = size(bits_modulated_16PSK_ML_MANUAL, 2);
    
    len_8PSK_nocod = size(bits_modulated_8PSK_nocod, 2);
    len_8PSK_M17 = size(bits_modulated_8PSK_M17, 2);
    len_8PSK_TCH_HS = size(bits_modulated_8PSK_TCH_HS, 2);
    len_8PSK_ML_MANUAL = size(bits_modulated_8PSK_ML_MANUAL, 2);
    
    
    Eb_N0_dB = 0:1:12; %faixa de Eb/N0
    Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
    
    
    %%pré-alocação dos vetores de BER
    ber_16PSK_nocod = zeros(size(Eb_N0_lin)); 
    ber_16PSK_M17 = zeros(size(Eb_N0_lin)); 
    ber_16PSK_TCH_HS = zeros(size(Eb_N0_lin));
    ber_16PSK_ML_MANUAL = zeros(size(Eb_N0_lin)); 
    
    ber_8PSK_nocod = zeros(size(Eb_N0_lin)); 
    ber_8PSK_M17 = zeros(size(Eb_N0_lin)); 
    ber_8PSK_TCH_HS = zeros(size(Eb_N0_lin)); 
    ber_8PSK_ML_MANUAL = zeros(size(Eb_N0_lin)); 
    
    
    Es = 1;
    Eb_16PSK = Es / (log2(M_16PSK)); % energia por bit para a modulação 16PSK utilizada
    Eb_8PSK = Es / (log2(M_8PSK)); % energia por bit p/ a modulação 8PSK

    NP_8PSK = Eb_8PSK ./ (Eb_N0_lin); %vetor de potências do ruído
    NP_16PSK = Eb_16PSK ./ (Eb_N0_lin); %vetor de potências do ruído
    
    %Penaliza os códigos convolucionais multiplicando a potencia do ruído.
    NA_16PSK_nocod =        sqrt(NP_16PSK); %vetor de amplitudes do ruído
    NA_16PSK_M17 =          sqrt(NP_16PSK * noise_potency_multiplier_M17); %vetor de amplitudes do ruído
    NA_16PSK_TCH_HS =       sqrt(NP_16PSK * noise_potency_multiplier_TCH_HS); %vetor de amplitudes do ruído
    NA_16PSK_ML_MANUAL =    sqrt(NP_16PSK * noise_potency_multiplier_ML_MANUAL); %vetor de amplitudes do ruído
    
    NA_8PSK_nocod =        sqrt(NP_8PSK); %vetor de amplitudes do ruído
    NA_8PSK_M17 =          sqrt(NP_8PSK * noise_potency_multiplier_M17); %vetor de amplitudes do ruído
    NA_8PSK_TCH_HS =       sqrt(NP_8PSK * noise_potency_multiplier_TCH_HS); %vetor de amplitudes do ruído
    NA_8PSK_ML_MANUAL =    sqrt(NP_8PSK * noise_potency_multiplier_ML_MANUAL); %vetor de amplitudes do ruído
    
    %Parâmetros para serem usados na decodificação de viterbi.
    tbdepth = 40;
    opmode = 'trunc';
    dectype = 'hard';

    for i = 1:length(Eb_N0_lin)
        tic
        %Gera ruídos para cada combinação de modulação e codificação.
        n_16PSK_nocod =     NA_16PSK_nocod(i)       * complex(randn(1, len_16PSK_nocod), randn(1, len_16PSK_nocod))*sqrt(0.5); %vetor de ruído complexo com desvio padrão igual a uma posição do vetor NA
        n_16PSK_M17 =       NA_16PSK_M17(i)         * complex(randn(1, len_16PSK_M17), randn(1, len_16PSK_M17))*sqrt(0.5);
        n_16PSK_TCH_HS =    NA_16PSK_TCH_HS(i)      * complex(randn(1, len_16PSK_TCH_HS), randn(1, len_16PSK_TCH_HS))*sqrt(0.5);
        n_16PSK_ML_MANUAL = NA_16PSK_ML_MANUAL(i)   * complex(randn(1, len_16PSK_ML_MANUAL), randn(1, len_16PSK_ML_MANUAL))*sqrt(0.5);
        
        n_8PSK_nocod =      NA_8PSK_nocod(i)         * complex(randn(1, len_8PSK_nocod), randn(1, len_8PSK_nocod))*sqrt(0.5); %vetor de ruído complexo com desvio padrão igual a uma posição do vetor NA
        n_8PSK_M17 =        NA_8PSK_M17(i)           * complex(randn(1, len_8PSK_M17), randn(1, len_8PSK_M17))*sqrt(0.5);
        n_8PSK_TCH_HS =     NA_8PSK_TCH_HS(i)        * complex(randn(1, len_8PSK_TCH_HS), randn(1, len_8PSK_TCH_HS))*sqrt(0.5);
        n_8PSK_ML_MANUAL =  NA_8PSK_ML_MANUAL(i)     * complex(randn(1, len_8PSK_ML_MANUAL), randn(1, len_8PSK_ML_MANUAL))*sqrt(0.5);
        
        
        %Gera os bits modulados ruidosos
        r_16PSK_nocod =     bits_modulated_16PSK_nocod + n_16PSK_nocod; % vetor recebido
        r_16PSK_M17 =       bits_modulated_16PSK_M17 + n_16PSK_M17; % vetor recebido
        r_16PSK_TCH_HS =    bits_modulated_16PSK_TCH_HS + n_16PSK_TCH_HS; % vetor recebido
        r_16PSK_ML_MANUAL = bits_modulated_16PSK_ML_MANUAL + n_16PSK_ML_MANUAL; % vetor recebido
        
        r_8PSK_nocod =      bits_modulated_8PSK_nocod + n_8PSK_nocod; % vetor recebido
        r_8PSK_M17 =        bits_modulated_8PSK_M17 + n_8PSK_M17; % vetor recebido
        r_8PSK_TCH_HS =     bits_modulated_8PSK_TCH_HS + n_8PSK_TCH_HS; % vetor recebido
        r_8PSK_ML_MANUAL =  bits_modulated_8PSK_ML_MANUAL + n_8PSK_ML_MANUAL; % vetor recebido
        
        
        %Faz a demodulação dos bits ruidosos, os aproximando aos pontos
        %16PSK e 8PSK mais próximos.
        demod_16PSK_nocod =     recover_modulated_bits_16PSK(r_16PSK_nocod);
        demod_16PSK_M17 =       recover_modulated_bits_16PSK(r_16PSK_M17);
        demod_16PSK_TCH_HS =    recover_modulated_bits_16PSK(r_16PSK_TCH_HS);
        demod_16PSK_ML_MANUAL = recover_modulated_bits_16PSK(r_16PSK_ML_MANUAL);
        
        demod_8PSK_nocod =      recover_modulated_bits_8PSK(r_8PSK_nocod);
        demod_8PSK_M17 =        recover_modulated_bits_8PSK(r_8PSK_M17);
        demod_8PSK_TCH_HS =     recover_modulated_bits_8PSK(r_8PSK_TCH_HS);
        demod_8PSK_ML_MANUAL =  recover_modulated_bits_8PSK(r_8PSK_ML_MANUAL);
        
        
        %Decodifica o conteúdo demodulado.
        demod_and_decod_16PSK_nocod =       demod_16PSK_nocod;
        demod_and_decod_16PSK_M17 =         vitdec(demod_16PSK_M17, trellis_M17, tbdepth, opmode, dectype);
        demod_and_decod_16PSK_TCH_HS =      vitdec(demod_16PSK_TCH_HS, trellis_TCH_HS, tbdepth, opmode, dectype);
        demod_and_decod_16PSK_ML_MANUAL =   vitdec(demod_16PSK_ML_MANUAL, trellis_ML_MANUAL, tbdepth, opmode, dectype);
        
        demod_and_decod_8PSK_nocod =        demod_8PSK_nocod;
        demod_and_decod_8PSK_M17 =          vitdec(demod_8PSK_M17, trellis_M17, tbdepth, opmode, dectype);
        demod_and_decod_8PSK_TCH_HS =       vitdec(demod_8PSK_TCH_HS, trellis_TCH_HS, tbdepth, opmode, dectype);
        demod_and_decod_8PSK_ML_MANUAL =    vitdec(demod_8PSK_ML_MANUAL, trellis_ML_MANUAL, tbdepth, opmode, dectype);
        
        
        %Faz a contagem de erros
        ber_16PSK_nocod(i)      = sum(original_bits ~= demod_and_decod_16PSK_nocod) / num_b; % contagem de erros e cálculo do BER
        ber_16PSK_M17(i)        = sum(original_bits ~= demod_and_decod_16PSK_M17) / num_b; % contagem de erros e cálculo do BER
        ber_16PSK_TCH_HS(i)     = sum(original_bits ~= demod_and_decod_16PSK_TCH_HS) / num_b; % contagem de erros e cálculo do BER
        ber_16PSK_ML_MANUAL(i)  = sum(original_bits ~= demod_and_decod_16PSK_ML_MANUAL) / num_b; % contagem de erros e cálculo do BER
        
        ber_8PSK_nocod(i)      = sum(original_bits ~= demod_and_decod_8PSK_nocod) / num_b; % contagem de erros e cálculo do BER
        ber_8PSK_M17(i)        = sum(original_bits ~= demod_and_decod_8PSK_M17) / num_b; % contagem de erros e cálculo do BER
        ber_8PSK_TCH_HS(i)     = sum(original_bits ~= demod_and_decod_8PSK_TCH_HS) / num_b; % contagem de erros e cálculo do BER
        ber_8PSK_ML_MANUAL(i)  = sum(original_bits ~= demod_and_decod_8PSK_ML_MANUAL) / num_b; % contagem de erros e cálculo do BER
        i
        toc
    end
    
    result = [ber_16PSK_nocod, ...
              ber_16PSK_M17, ...
              ber_16PSK_TCH_HS, ...
              ber_16PSK_ML_MANUAL,...
              ber_8PSK_nocod, ...
              ber_8PSK_M17, ...
              ber_8PSK_TCH_HS, ...
              ber_8PSK_ML_MANUAL]

    plot(Eb_N0_dB, ber_16PSK_nocod, 'b-'); hold on;
    plot(Eb_N0_dB, ber_16PSK_M17, 'r-'); hold on;
    plot(Eb_N0_dB, ber_16PSK_TCH_HS, 'g-'); hold on;
    plot(Eb_N0_dB, ber_16PSK_ML_MANUAL, 'c-'); hold on;
    
    plot(Eb_N0_dB, ber_8PSK_nocod, 'b-.'); hold on;
    plot(Eb_N0_dB, ber_8PSK_M17, 'r-.'); hold on;
    plot(Eb_N0_dB, ber_8PSK_TCH_HS, 'g-.'); hold on;
    plot(Eb_N0_dB, ber_8PSK_ML_MANUAL, 'c-.'); hold off;
    
    xlabel('Eb/N0 (dB)');
    ylabel('BER');
    legend('16PSK - NoCode','16PSK - M17', '16PSK - TCH-HS', '16PSK - ML MANUAL', ...
           '8PSK - NoCode','8PSK - M17', '8PSK - TCH-HS', '8PSK - ML MANUAL');
end
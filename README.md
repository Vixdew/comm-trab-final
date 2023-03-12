# Análise de BER (Bit Error Rate) entre diferentes modulações e códigos convolucionais

Uma análise em Matlab da taxa de erro de bit das modulações 16-PSK e 8-PSK quando usadas sem código de canal, com código convolucional baseado no padrão de rádio amador M-17, baseado no padrão TCH-HS, e num código convolucional usado de exemplo no manual do Matlab.

Feito como trabalho final para a cadeira de Comunicação de Dados.

## Bit Error Rate

Bit Error Rate se refere a taxa de erro de uma stream de dados quando enviados via um meio de comunicação. Em específico, é usada para medir a taxa de erro em relação aos bits de informação enviados, sem contar quaisquer bits de redundância presentes na stream de bits.

Nesta análise, estamos interessados em simular a transmissão de uma stream de 1.000.200 bits de dados sobre um meio ruidoso. 

Primeiro encodificamos a stream de dados segundo os padrões M-17, TCH-HS e ML Manual, para depois modularmos essas streams via modulação 8-PSK e 16-PSK com código de Gray.

Após moduladas, adicionamos ruído ao conteúdo modulado, desmodulamos aproximando o melhor que a modulação consegue, e depois medimos a taxa de erros.

Fazemos isso para diferentes taxas de sinal-ruído, gerando o gráfico abaixo.

# Análise de BER (Bit Error Rate) entre diferentes modulações e códigos convolucionais

Uma análise em Matlab da taxa de erro de bit das modulações 16-PSK e 8-PSK quando usadas sem código de canal, com código convolucionais baseados no padrão de rádio amador [M-17](https://spec.m17project.org/), baseado no padrão [TCH-HS](https://www.etsi.org/deliver/etsi_gts/05/0503/05.00.00_60/gsmts_0503v050000p.pdf), e baseado num código convolucional usado de exemplo no [manual do Matlab](https://www.mathworks.com/help/comm/ug/error-detection-and-correction.html##fp7405)(ML Manual) sob a seção '*Use Trellis Structure for Rate 1/2 Feedback Convolutional Encoder*'.

Feito como trabalho final para a cadeira de Comunicação de Dados.

## Bit Error Rate

Bit Error Rate se refere a taxa de erro de uma stream de dados quando enviados via um meio de comunicação. Em específico, é usada para medir a taxa de erro em relação aos bits de informação enviados, sem contar quaisquer bits de redundância presentes na stream de bits. Isso é importante pois implica que, havendo presença de bits de redundância, precisamos penalizar esse código de acordo com a sua razão via a potencialização do ruído adicionado ao sinal dele. Isto se dá pois se aplicarmos o mesmo ruído para uma modulação sem código e um código convolucional com razão 1/5, o ruído relativo a cada bit de informação será muito diferente, favorecendo o código convolucional.

## Metodologia

Nesta análise, estamos interessados em simular a transmissão de uma stream de 1.000.200 bits de dados sobre um meio ruidoso. 

Primeiro encodificamos a stream de dados segundo os padrões M-17, TCH-HS e ML Manual, para depois modularmos essas streams via modulação 8-PSK e 16-PSK com código de Gray.

Após moduladas, adicionamos ruído ao conteúdo modulado, desmodulamos aproximando o melhor que a modulação consegue, e depois medimos a taxa de erros.

## Resultados

Fazemos isso para diferentes taxas de sinal-ruído, gerando o gráfico abaixo.

![Alt text](resultados.png?raw=true "Title")

## Análise

Como se pode observar no resultado acima, por conta das punições as simulações com código são piores que as sem código em ambas as modulações para valores baixos de $Eb/N_0$. Isso se deve ao fato que como poucos erros ocorrem, não vale a pena a utilização de redundância para corrigir os erros. Pode-se observar também que os códigos na modulação 8-PSK tem um BER menor que os 16-PSK, que é o resultado esperado devido à maior fragilidade do 16-PSK a ruído, e no geral é necessário uma taxa $Eb/N_0$ maior para que os códigos comecem a ter um BER menor que as modulações sem código. Com o aumento da relação sinal-ruído, porém, os códigos convolucionais consegue ter desempenho melhor que os sem códigos. 

Foi interessante notar, também, que mesmo TCH-HS sendo um padrão utilizado na vida real, ele teve um desempenho pior que um código de exemplo do manual do Matlab. Acreditamos que isso acontece pois no TCH-HS usado na vida real, o padrão utiliza de outras medidas de redundância (perfuração, bits de paridade) que devem o tornam mais resiliente que a versão que utiliza apenas o seu código convolucional. Essa análise vale também para o M17, já que ele também tem outras medidas além do código convolucional para garantir sua resiliência, mas analisando apenas os códigos convolucionais, o código convolucional com feedback especificado no manual do Matlab tem a melhor performance e a menor taxa de erro.

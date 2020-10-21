# Thunderbird
O código para a execução do sistema de setas no Thunderbird inicia-se com a chamada das bibliotecas que serão utilizadas. Em seguida nomeamos a entidade Thunderbird e uma variável(GENERIC) do tipo inteiro e chamada SEG, a qual permite alterar facilmente o intervalo entre as ações dos leds, por padrão assume o valor de 24999999 a qual correspondera a 0,5 seg. O passo seguinte é a definição das portas, a qual teremos SW como entrada e vetor de 9 a 0( Sendo as posições 1 e 0 responsáveis por agir como a alavanca de seta seguindo o modelo na Figura 1), LEDR um buffer com vetor de 9 a 7(Identificados pelo retângulo vermelho na figura 1) indicativos da seta esquerda, LEDG também um buffer vetor de 2 a 0(Indicados pelo retângulo verde na figura 1) indicativos da seta a direita e por fim CLOCK_50 o qual é a entrada do clock de 50 MHz da placa utilizada. Passamos então a descrever a arquitetura nomeada rtl, criamos um SIGNAL chamado temp que varia de 0 até SEG. Iniciamos então um código sequencialsensível em SW e CLOCK_50. Um condicional detecta a borda de subida do clock, um outro sequencial identifica se temp é diferente de SEG, se for então incrementa 1 a temp. Senão iguala a 0 e chama um condicional para identificar a posição de SW 1 e 0, se for 01 inicia um case com LEDG o qual atualiza da seguinte forma 000->100->110->111->000, se não for, mas 10 entao um case com LEDR é iniciado alterando de 000->001->011->111->000, senão, mas 11 entao um case é iniciado com LEDR mas o qual alterara ambos os leds no padrão definido anteriormente para SW 01 e 10, senão, mas 00 então apaga todos. 

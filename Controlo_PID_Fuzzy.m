%----------------------POSIÇÃO--------------------------------------
%Função Controlo da Posição
posFIS=mamfis('NumInputs', 1, 'NumInputMFs', 7, 'NumOutputs', 1, 'NumOutputMFs', 7,'AddRule', 'none');

%Input- Erro da posição
posFIS.Inputs(1).Name='Posição';
posFIS.Inputs(1).Range=[-200 200]; 

posFIS.Inputs (1). MembershipFunctions (1).Name = 'NG'; 
posFIS.Inputs(1). MembershipFunctions (1).Type = 'trimf'; 
posFIS.Inputs(1). MembershipFunctions (1). Parameters = [-200 -150 -100];

posFIS.Inputs (1). MembershipFunctions(2).Name = 'NM'; 
posFIS.Inputs(1). MembershipFunctions (2).Type = 'trimf'; 
posFIS.Inputs(1). MembershipFunctions (2). Parameters = [-150 -100 -50];

posFIS.Inputs (1). MembershipFunctions(3).Name = 'NS'; 
posFIS.Inputs(1). MembershipFunctions (3).Type = 'trimf'; 
posFIS.Inputs(1). MembershipFunctions (3). Parameters = [-100 -50 0];

posFIS.Inputs (1). MembershipFunctions(4).Name = 'PG'; 
posFIS.Inputs(1). MembershipFunctions (4).Type = 'trimf'; 
posFIS.Inputs(1). MembershipFunctions (4). Parameters = [100 150 200];

posFIS.Inputs (1). MembershipFunctions(5).Name = 'PM'; 
posFIS.Inputs(1). MembershipFunctions (5).Type = 'trimf'; 
posFIS.Inputs(1). MembershipFunctions (5). Parameters = [50 100 150];

posFIS.Inputs (1). MembershipFunctions(6).Name = 'PS'; 
posFIS.Inputs(1). MembershipFunctions (6).Type = 'trimf'; 
posFIS.Inputs(1). MembershipFunctions (6). Parameters = [0 50 100];

posFIS.Inputs(1).MembershipFunctions(7).Name= 'Zero';
posFIS.Inputs(1).MembershipFunctions(7).Type='trimf';
posFIS.Inputs(1).MembershipFunctions(7).Parameters=[-5 0 5];

figure(1)
subplot(1,2,1)
plotmf(posFIS,'input',1,1000);
title('Input')


%Output- Velocidade do carrinho
posFIS.Outputs (1).Name = 'Velocidade_Saída'; 
posFIS.Outputs(1).Range = [-1200 1200];

posFIS.Outputs (1). MembershipFunctions(1).Name = 'NG'; 
posFIS.Outputs(1). MembershipFunctions (1).Type = 'trimf'; 
posFIS.Outputs(1). MembershipFunctions (1). Parameters = [-1200 -900 -600];

posFIS.Outputs (1). MembershipFunctions (2).Name = 'NM'; 
posFIS.Outputs(1). MembershipFunctions (2).Type = 'trimf'; 
posFIS.Outputs(1). MembershipFunctions (2). Parameters = [-900 -600 -300];

posFIS.Outputs (1). MembershipFunctions (3).Name = 'NS'; 
posFIS.Outputs(1). MembershipFunctions (3).Type = 'trimf'; 
posFIS.Outputs(1). MembershipFunctions (3). Parameters = [-600 -300 0];

posFIS.Outputs (1). MembershipFunctions (4).Name = 'PG'; 
posFIS.Outputs(1). MembershipFunctions (4).Type = 'trimf'; 
posFIS.Outputs(1). MembershipFunctions (4). Parameters = [600 900 1200];

posFIS.Outputs (1). MembershipFunctions (5).Name = 'PM'; 
posFIS.Outputs(1). MembershipFunctions (5).Type = 'trimf'; 
posFIS.Outputs(1). MembershipFunctions (5). Parameters = [300 600 900];

posFIS.Outputs (1). MembershipFunctions (6).Name = 'PS'; 
posFIS.Outputs(1). MembershipFunctions (6).Type = 'trimf'; 
posFIS.Outputs(1). MembershipFunctions (6). Parameters = [0 300 600];

posFIS.Outputs (1). MembershipFunctions (7).Name = 'Zero'; 
posFIS.Outputs(1). MembershipFunctions (7).Type = 'trimf'; 
posFIS.Outputs(1). MembershipFunctions (7). Parameters = [-50 0 50];



subplot(1,2,2)
plotmf(posFIS,'output',1,1000)
title('Output')

%Regras

rules=[...
    "If Posição is NG then Velocidade_Saída is NG";...
    "If Posição is NM then Velocidade_Saída is NM";...
    "If Posição is NS then Velocidade_Saída is NS";...
    "If Posição is PG then Velocidade_Saída is PG";...
    "If Posição is PM then Velocidade_Saída is PM";...
    "If Posição is PS then Velocidade_Saída is PS";...
    "If Posição is Zero then Velocidade_Saída is Zero"];

posFIS=addRule(posFIS,rules);

%--------------------------------PENDULO----------------------------
%Dados do pendulo
m =0.214;
J=0.0051;
C=0.0026;
l=0.275;
Jeq=J+m*l^2;
g=9.8;

%Função controlo do pêndulo
pendFIS=mamfis('NumInputs', 2, 'NumInputMFs', 3, 'NumOutputs', 1, 'NumOutputMFs', 5,'AddRule', 'none');

%Input 1- Erro do ângulo (theta)
pendFIS.Inputs(1).Name='Angulo';
pendFIS.Inputs(1).Range=[-pi/12 pi/12]; 

pendFIS.Inputs (1). MembershipFunctions (1).Name = 'N'; 
pendFIS.Inputs(1). MembershipFunctions (1).Type = 'zmf'; 
pendFIS.Inputs(1). MembershipFunctions (1). Parameters = [-pi/12 pi/12];

pendFIS.Inputs (1). MembershipFunctions(2).Name = 'P'; 
pendFIS.Inputs(1). MembershipFunctions (2).Type = 'smf'; 
pendFIS.Inputs(1). MembershipFunctions (2). Parameters = [-pi/12 pi/12];

pendFIS.Inputs (1). MembershipFunctions (3).Name = 'Zero'; 
pendFIS.Inputs(1). MembershipFunctions (3).Type = 'trimf'; 
pendFIS.Inputs(1). MembershipFunctions (3). Parameters = [-0.05 0 0.05];


%Input 2- Erro da derivada do ângulo (theta_dot)
pendFIS.Inputs(2).Name='Angulo_d';
pendFIS.Inputs(2).Range=[-10 10]; 

pendFIS.Inputs (2). MembershipFunctions (1).Name = 'N'; 
pendFIS.Inputs(2). MembershipFunctions (1).Type = 'zmf'; 
pendFIS.Inputs(2). MembershipFunctions (1). Parameters = [-10 10];

pendFIS.Inputs (2). MembershipFunctions(2).Name = 'P'; 
pendFIS.Inputs(2). MembershipFunctions (2).Type = 'smf'; 
pendFIS.Inputs(2). MembershipFunctions (2). Parameters = [-10 10];

pendFIS.Inputs (2). MembershipFunctions (3).Name = 'Zero'; 
pendFIS.Inputs(2). MembershipFunctions (3).Type = 'trimf'; 
pendFIS.Inputs(2). MembershipFunctions (3). Parameters = [-1 0 1];

figure(2)
subplot(1,3,1)
plotmf(pendFIS,'input',1,1000);
title('Input 1')
subplot(1,3,2)
plotmf(pendFIS,'input',2,1000);
title('Input 2')

%Output - Velocidade do carrinho
pendFIS.Outputs (1).Name = 'Velocidade_Saída'; 
pendFIS.Outputs(1).Range = [-1200 1200];

pendFIS.Outputs (1). MembershipFunctions(1).Name = 'NG'; 
pendFIS.Outputs(1). MembershipFunctions (1).Type = 'trimf'; 
pendFIS.Outputs(1). MembershipFunctions (1). Parameters = [-1200 -800 -400];

pendFIS.Outputs (1). MembershipFunctions (2).Name = 'NM'; 
pendFIS.Outputs(1). MembershipFunctions (2).Type = 'trimf'; 
pendFIS.Outputs(1). MembershipFunctions (2). Parameters = [-800 -400 0];

pendFIS.Outputs (1). MembershipFunctions (3).Name = 'PG'; 
pendFIS.Outputs(1). MembershipFunctions (3).Type = 'trimf'; 
pendFIS.Outputs(1). MembershipFunctions (3). Parameters = [400 800 1200];

pendFIS.Outputs (1). MembershipFunctions (4).Name = 'PM'; 
pendFIS.Outputs(1). MembershipFunctions (4).Type = 'trimf'; 
pendFIS.Outputs(1). MembershipFunctions (4). Parameters = [0 400 800];

pendFIS.Outputs (1). MembershipFunctions (5).Name = 'Zero'; 
pendFIS.Outputs(1). MembershipFunctions (5).Type = 'trimf'; 
pendFIS.Outputs(1). MembershipFunctions (5). Parameters = [-400 0 400];


subplot(1,3,3)
plotmf(pendFIS,'output',1,1000)
title('Output')

%Regras

rules=[...
    "If Angulo is N then Velocidade_Saída is NM";...
    "If Angulo is P then Velocidade_Saída is PM";...
    "If Angulo_d is N then Velocidade_Saída is NG";...
    "If Angulo_d is P then Velocidade_Saída is PG";
    "If Angulo is Zero then Velocidade_Saída is Zero";
    "If Angulo_d is Zero then Velocidade_Saída is Zero"];


pendFIS=addRule(pendFIS,rules);

%--------------------------DESAFIO------------------------------------

%Função 5 Funções de pertença
posFIS5=mamfis('NumInputs', 1, 'NumInputMFs', 5, 'NumOutputs', 1, 'NumOutputMFs', 5,'AddRule', 'none');

%Input 1- Erro da Posição
posFIS5.Inputs(1).Name='Posição';
posFIS5.Inputs(1).Range=[-200 200]; 

posFIS5.Inputs (1). MembershipFunctions (1).Name = 'N1'; 
posFIS5.Inputs(1). MembershipFunctions (1).Type = 'trimf'; 
posFIS5.Inputs(1). MembershipFunctions (1). Parameters = [-200 -133 -66];

posFIS5.Inputs (1). MembershipFunctions(2).Name = 'N2'; 
posFIS5.Inputs(1). MembershipFunctions (2).Type = 'trimf'; 
posFIS5.Inputs(1). MembershipFunctions (2). Parameters = [-133 -66 0];

posFIS5.Inputs (1). MembershipFunctions(3).Name = 'P1'; 
posFIS5.Inputs(1). MembershipFunctions (3).Type = 'trimf'; 
posFIS5.Inputs(1). MembershipFunctions (3). Parameters = [66 133 200];

posFIS5.Inputs (1). MembershipFunctions(4).Name = 'P2'; 
posFIS5.Inputs(1). MembershipFunctions (4).Type = 'trimf'; 
posFIS5.Inputs(1). MembershipFunctions (4). Parameters = [0 66 133];

posFIS5.Inputs (1). MembershipFunctions(5).Name = 'Zero'; 
posFIS5.Inputs(1). MembershipFunctions (5).Type = 'trimf'; 
posFIS5.Inputs(1). MembershipFunctions (5). Parameters = [-66 0 66];



%Output- Velocidade do Carrinho
posFIS5.Outputs (1).Name = 'Velocidade_Saída'; 
posFIS5.Outputs(1).Range = [-1200 1200];

posFIS5.Outputs (1). MembershipFunctions(1).Name = 'N1'; 
posFIS5.Outputs(1). MembershipFunctions (1).Type = 'trimf'; 
posFIS5.Outputs(1). MembershipFunctions (1). Parameters = [-1200 -800 -400];

posFIS5.Outputs (1). MembershipFunctions (2).Name = 'N2'; 
posFIS5.Outputs(1). MembershipFunctions (2).Type = 'trimf'; 
posFIS5.Outputs(1). MembershipFunctions (2). Parameters = [-800 -400 0];

posFIS5.Outputs (1). MembershipFunctions (3).Name = 'P1'; 
posFIS5.Outputs(1). MembershipFunctions (3).Type = 'trimf'; 
posFIS5.Outputs(1). MembershipFunctions (3). Parameters = [400 800 1200];

posFIS5.Outputs (1). MembershipFunctions (4).Name = 'P2'; 
posFIS5.Outputs(1). MembershipFunctions (4).Type = 'trimf'; 
posFIS5.Outputs(1). MembershipFunctions (4). Parameters = [0 400 800];

posFIS5.Outputs (1). MembershipFunctions (5).Name = 'Zero'; 
posFIS5.Outputs(1). MembershipFunctions (5).Type = 'trimf'; 
posFIS5.Outputs(1). MembershipFunctions (5). Parameters = [-400 0 400];



%Regras

rules=[...
    "If Posição is N1 then Velocidade_Saída is N1";...
    "If Posição is N2 then Velocidade_Saída is N2";...
    "If Posição is P1 then Velocidade_Saída is P1";...
    "If Posição is P2 then Velocidade_Saída is P2";...
    "IF Posição is Zero then Velocidade_Saída is Zero"];

posFIS5=addRule(posFIS5,rules);


%Função 11 Funções de Pertença
posFIS11=mamfis('NumInputs', 1, 'NumInputMFs', 11, 'NumOutputs', 1, 'NumOutputMFs', 11,'AddRule', 'none');

%Input- Erro da Posição
posFIS11.Inputs(1).Name='Posição';
posFIS11.Inputs(1).Range=[-200 200]; 

posFIS11.Inputs (1). MembershipFunctions (1).Name = 'N1'; 
posFIS11.Inputs(1). MembershipFunctions (1).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (1). Parameters = [-200 -167 -133];

posFIS11.Inputs (1). MembershipFunctions(2).Name = 'N2'; 
posFIS11.Inputs(1). MembershipFunctions (2).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (2). Parameters = [-167 -133 -100];

posFIS11.Inputs (1). MembershipFunctions(3).Name = 'N3'; 
posFIS11.Inputs(1). MembershipFunctions (3).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (3). Parameters = [-133 -100 -66];

posFIS11.Inputs (1). MembershipFunctions(4).Name = 'N4'; 
posFIS11.Inputs(1). MembershipFunctions (4).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (4). Parameters = [-100 -66 -33];

posFIS11.Inputs (1). MembershipFunctions(5).Name = 'N5'; 
posFIS11.Inputs(1). MembershipFunctions (5).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (5). Parameters = [-66 -33 0];

posFIS11.Inputs (1). MembershipFunctions(6).Name = 'P1'; 
posFIS11.Inputs(1). MembershipFunctions (6).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (6). Parameters = [133 167 200];

posFIS11.Inputs (1). MembershipFunctions(7).Name = 'P2'; 
posFIS11.Inputs(1). MembershipFunctions (7).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (7). Parameters = [100 133 167];

posFIS11.Inputs (1). MembershipFunctions(8).Name = 'P3'; 
posFIS11.Inputs(1). MembershipFunctions (8).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (8). Parameters = [66 100 133];

posFIS11.Inputs (1). MembershipFunctions(9).Name = 'P4'; 
posFIS11.Inputs(1). MembershipFunctions (9).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (9). Parameters = [33 66 100];

posFIS11.Inputs (1). MembershipFunctions(10).Name = 'P5'; 
posFIS11.Inputs(1). MembershipFunctions (10).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (10). Parameters = [0 33 66];

posFIS11.Inputs (1). MembershipFunctions(11).Name = 'Zero'; 
posFIS11.Inputs(1). MembershipFunctions (11).Type = 'trimf'; 
posFIS11.Inputs(1). MembershipFunctions (11). Parameters = [-33 0 33];


%Output- Velocidade do carrinho
posFIS11.Outputs (1).Name = 'Velocidade_Saída'; 
posFIS11.Outputs(1).Range = [-1200 1200];

posFIS11.Outputs (1). MembershipFunctions(1).Name = 'N1'; 
posFIS11.Outputs(1). MembershipFunctions (1).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (1). Parameters = [-1200 -1000 -800];

posFIS11.Outputs (1). MembershipFunctions (2).Name = 'N2'; 
posFIS11.Outputs(1). MembershipFunctions (2).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (2). Parameters = [-1000 -800 -600];

posFIS11.Outputs (1). MembershipFunctions (3).Name = 'N3'; 
posFIS11.Outputs(1). MembershipFunctions (3).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (3). Parameters = [-800 -600 -400];

posFIS11.Outputs (1). MembershipFunctions (4).Name = 'N4'; 
posFIS11.Outputs(1). MembershipFunctions (4).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (4). Parameters = [-600 -400 -200];

posFIS11.Outputs (1). MembershipFunctions (5).Name = 'N5'; 
posFIS11.Outputs(1). MembershipFunctions (5).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (5). Parameters = [-400 -200 0];

posFIS11.Outputs (1). MembershipFunctions (6).Name = 'P1'; 
posFIS11.Outputs(1). MembershipFunctions (6).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (6). Parameters = [800 1000 1200];

posFIS11.Outputs (1). MembershipFunctions (7).Name = 'P2'; 
posFIS11.Outputs(1). MembershipFunctions (7).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (7). Parameters = [600 800 1000];

posFIS11.Outputs (1). MembershipFunctions (8).Name = 'P3'; 
posFIS11.Outputs(1). MembershipFunctions (8).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (8). Parameters = [400 600 800];

posFIS11.Outputs (1). MembershipFunctions (9).Name = 'P4'; 
posFIS11.Outputs(1). MembershipFunctions (9).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (9). Parameters = [200 400 600];

posFIS11.Outputs (1). MembershipFunctions (10).Name = 'P5'; 
posFIS11.Outputs(1). MembershipFunctions (10).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (10). Parameters = [0 200 400];

posFIS11.Outputs (1). MembershipFunctions (11).Name = 'Zero'; 
posFIS11.Outputs(1). MembershipFunctions (11).Type = 'trimf'; 
posFIS11.Outputs(1). MembershipFunctions (11). Parameters = [-200 0 200];



%Regras

rules=[...
    "If Posição is N1 then Velocidade_Saída is N1";...
    "If Posição is N2 then Velocidade_Saída is N2";...
    "If Posição is N3 then Velocidade_Saída is N3";...
    "If Posição is N4 then Velocidade_Saída is N4";...
    "If Posição is N5 then Velocidade_Saída is N5";...
    "If Posição is P1 then Velocidade_Saída is P1";...
    "If Posição is P2 then Velocidade_Saída is P2";...
    "If Posição is P3 then Velocidade_Saída is P3";...
    "If Posição is P4 then Velocidade_Saída is P4";...
    "If Posição is P5 then Velocidade_Saída is P5";...
    "IF Posição is Zero then Velocidade_Saída is Zero"];

posFIS11=addRule(posFIS11,rules);

%----------------------------SIMULAR-------------------------------------

%SIMULAR POSIÇÃO
out=sim("ControloPosicao.slx");

%Sinosoidal
figure(3)
subplot(2,2,1)
t=out.tout;
s1=out.SinRealPID.signals.values(:,1);
s2=out.SinRealPID.signals.values(:,2);
erros_sin_1=abs(s2-s1);
erro_sin_1=mean((erros_sin_1).^2);
plot(t,s1),
hold on
plot(t,s2),legend('Real','PID'), title('Sinal Real e PID')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,2)
s1=out.SinRealFuzzy1.signals.values(:,1);
s2=out.SinRealFuzzy1.signals.values(:,2);
erros_sin_2=abs(s2-s1);
erro_sin_2=mean((erros_sin_2).^2);
plot(t,s1)
hold on
plot(t,s2),legend('Real','Fuzzy'), title('Sinal Real e Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,3)
s1=out.SinAll.signals.values(:,1); %real
s2=out.SinAll.signals.values(:,2); %fuzzy 7
s3=out.SinAll.signals.values(:,3); %fuzzy 11
s4=out.SinAll.signals.values(:,4); %fuzzy 5
%erro 7f
erros_sin_3_5=abs(s4-s1);
erro_sin_3_5=mean((erros_sin_3_5).^2);
%erro 11f
erros_sin_3_11=abs(s3-s1);
erro_sin_3_11=mean((erros_sin_3_11).^2);
plot(t,s1)
hold on
plot(t,s2)
hold on
plot(t,s3)
hold on
plot(t,s4),legend('Real','Fuzzy 7 Funções', 'Fuzzy 11 Funções','Fuzzy 5 Funções') 
title('Sinal Real e ambos os Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,4)
s1=erros_sin_1;
s2=erros_sin_2;
s3=erros_sin_3_5;
s4=erros_sin_3_11;
plot(t,s1)
hold on
plot(t,s2)
plot(t,s3)
plot(t,s4)
xlabel('Tempo(s)'), ylabel('Erro(mm)')
legend('Erro PID','Erro Fuzzy Normal','Erro Fuzzy 5 funções','Erro Fuzzy 11 funções')
 


%Não Periodica
figure(4)
subplot(2,2,1)
t=out.tout;
s1=out.NPRealPID.signals.values(:,1);
s2=out.NPRealPID.signals.values(:,2);
erros_np_1=abs(s2-s1);
erro_np_1=mean((erros_np_1).^2);
plot(t,s1),
hold on
plot(t,s2),legend('Real','PID'), title('Sinal Real e PID')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,2)
s1=out.NPRealFuzzy1.signals.values(:,1);
s2=out.NPRealFuzzy1.signals.values(:,2);
erros_np_2=abs(s2-s1);
erro_np_2=mean((erros_np_2).^2);
plot(t,s1),
hold on
plot(t,s2),legend('Real','Fuzzy'), title('Real e Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,3)
s1=out.NPAll.signals.values(:,1); %real
s2=out.NPAll.signals.values(:,2); %fuuzzy normal
s3=out.NPAll.signals.values(:,3); %fuzzy 11
s4=out.NPAll.signals.values(:,4); %fuzzy 5
erros_np_3_11=abs(s3-s1);
erro_np_3_11=mean((erros_np_3_11.^2));
erros_np_3_5=abs(s4-s1);
erro_np_3_5=mean((erros_np_3_5).^2);
plot(t,s1)
hold on
plot(t,s2)
plot(t,s3)
plot(t,s4),legend('Real','Fuzzy 7 Funções', 'Fuzzy 11 Funções','Fuzzy 5 Funções') 
title('Sinal Real e ambos os Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,4)
s1=erros_np_1;
s2=erros_np_2;
s3=erros_np_3_5;
s4=erros_np_3_11;
plot(t,s1)
hold on
plot(t,s2)
plot(t,s3)
plot(t,s4)
xlabel('Tempo(s)'), ylabel('Erro(mm)')
legend('Erro PID','Erro Fuzzy Normal','Erro Fuzzy 5 funções','Erro Fuzzy 11 funções')


%Rampa
figure(5)
subplot(2,2,1)
t=out.tout;
s1=out.RampaRealPID.signals.values(:,1);
s2=out.RampaRealPID.signals.values(:,2);
erros_rampa_1=abs(s2-s1);
erro_rampa_1=mean((erros_rampa_1).^2);
plot(t(1:2500),s1(1:2500)),
hold on
plot(t(1:2500),s2(1:2500)),legend('Real','PID'), title('Sinal Real e PID')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')


subplot(2,2,2)
s1=out.RampaRealFuzzy1.signals.values(:,1);
s2=out.RampaRealFuzzy1.signals.values(:,2);
erros_rampa_2=abs(s2-s1);
erro_rampa_2=mean((erros_rampa_2).^2);
plot(t(1:2500),s1(1:2500)),
hold on
plot(t(1:2500),s2(1:2500)),legend('Real','Fuzzy'), title('Sinal Real e Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,3)
s1=out.RampaAll.signals.values(:,1); %real
s2=out.RampaAll.signals.values(:,2); %fuzzy normal
s3=out.RampaAll.signals.values(:,3); %fuzzy 11
s4=out.RampaAll.signals.values(:,4); %fuzzy 5
erros_rampa_3_5=abs(s4-s1);
erro_rampa_3_5=mean((erros_rampa_3_5).^2);
erros_rampa_3_11=abs(s3-s1);
erro_rampa_3_11=mean((erros_rampa_3_11).^2);
plot(t(1:2500),s1(1:2500))
hold on
plot(t(1:2500),s2(1:2500))
plot(t(1:2500),s3(1:2500))
plot(t(1:2500),s4(1:2500)),legend('Real','Fuzzy 7 Funções', 'Fuzzy 11 Funções','Fuzzy 5 Funções') 
title('Sinal Real e ambos os Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,4)
s1=erros_rampa_1;
s2=erros_rampa_2;
s3=erros_rampa_3_5;
s4=erros_rampa_3_11;
plot(t(1:2500),s1(1:2500))
hold on
plot(t(1:2500),s2(1:2500))
plot(t(1:2500),s3(1:2500))
plot(t(1:2500),s4(1:2500))
xlabel('Tempo(s)'), ylabel('Erro(mm)')
legend('Erro PID','Erro Fuzzy Normal','Erro Fuzzy 5 funções','Erro Fuzzy 11 funções')

%Step
figure(6)
subplot(2,2,1)
t=out.tout;
s1=out.StepRealPID.signals.values(:,1);
s2=out.StepRealPID.signals.values(:,2);
erros_step_1=abs(s2-s1);
erro_step_1=mean((erros_step_1).^2);
plot(t,s1),
hold on
plot(t,s2),legend('Real','PID'), title('Sinal Real e PID')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,2)
s1=out.StepRealFuzzy1.signals.values(:,1);
s2=out.StepRealFuzzy1.signals.values(:,2);
erros_step_2=abs(s2-s1);
erro_step_2=mean((erros_step_2).^2);
plot(t,s1)
hold on
plot(t,s2),legend('Real','Fuzzy'), title('Sinal Real e Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,3)
s1=out.StepAll.signals.values(:,1); %real
s2=out.StepAll.signals.values(:,2); %fuzzy 7
s3=out.StepAll.signals.values(:,3); %fuzzy 11
s4=out.StepAll.signals.values(:,4); %fuzzy 5
%erro 7f
erros_step_3_5=abs(s4-s1);
erro_step_3_5=mean((erros_step_3_5).^2);
%erro 11f
erros_step_3_11=abs(s3-s1);
erro_step_3_11=mean((erros_step_3_11).^2);
plot(t,s1)
hold on
plot(t,s2)
plot(t,s3)
plot(t,s4),legend('Real','Fuzzy 7 Funções', 'Fuzzy 11 Funções','Fuzzy 5 Funções') 
title('Sinal Real e ambos os Fuzzy')
xlabel('Tempo(s)'), ylabel('Amplitude(mm)')

subplot(2,2,4)
s1=erros_step_1;
s2=erros_step_2;
s3=erros_step_3_5;
s4=erros_step_3_11;
plot(t,s1)
hold on
plot(t,s2)
plot(t,s3)
plot(t,s4)
xlabel('Tempo(s)'), ylabel('Erro(mm)')
legend('Erro PID','Erro Fuzzy Normal','Erro Fuzzy 5 funções','Erro Fuzzy 11 funções')


%SIMULAR PÊNDULO
out2=sim('Pendulo.slx');


t=out2.tout;
s=out2.PendPID.signals.values(:,1);
erros_pend_pid=s;
erro_pend_pid=mean(erros_pend_pid.^2);
figure(7)
subplot(2,2,1)
plot(t,s)
xlabel('Tempo(s)'), ylabel('Ângulo(graus)'),title('Pêndulo PID')

s=out2.PendFuzzy.signals.values(:,1);
subplot(2,2,2)
plot(t,s)
xlabel('Tempo(s)'), ylabel('Ângulo(graus)'),title('Pêndulo Fuzzy')


% Filtragem do sinal
fs = 1000; % Taxa de amostragem 
cutoff = 2; % Frequência de corte
order = 6; % Ordem do filtro
[b, a] = butter(order, cutoff / (fs / 2), 'low');
s_bw = filtfilt(b, a, s);
erros_pend_fuzzy=s_bw;
erro_pend_fuzzy=mean(erros_pend_fuzzy.^2);

hold on;
subplot(2,2,3),plot(t, s_bw, 'g')
xlabel('Tempo (s)');
ylabel('Ângulo (graus)');

subplot(2,2,4)
s1=erros_pend_pid;
s2=erros_pend_fuzzy;
plot(t,s1)
hold on
plot(t,s2)
xlabel('Tempo (s)'), ylabel('Erro do ângulo');
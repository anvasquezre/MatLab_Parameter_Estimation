global Qs param Cinit 

load ParamTrabajo3param.txt
load alimidealopti.txt

Qs=alimidealopti(1);
param(1)=ParamTrabajo3param(1);
param(2)=ParamTrabajo3param(2);
param(3)=alimidealopti(2);
param(4)=ParamTrabajo3param(3);
param(5)=ParamTrabajo3param(4);
param(6)=ParamTrabajo3param(5);
%Condiciones iniciales
data_exp=xlsread('dataexp');
tspan=data_exp(:,1);
Cinit=data_exp(1,2:5);

%% Para el fedbatch con continuo

[t X]=ode45(@mAb_opti,tspan,Cinit);

%% Comparacion con discreto No opti

 
%Condiciones iniciales
data_q=xlsread('fedbatch');
Qs=[data_q(:,1) data_q(:,3)];
Cinit=data_exp(1,2:5);
param(3)=20;
% Para el fedbatch con flujo discreto

opts = odeset('NonNegative',1,'MaxStep',0.1);
[tt XX]=ode45(@mAb,tspan,Cinit,opts);

%% graficos

XMIN=0;
XMAX=14;
YMIN=0;
YMAX=inf;
figure(1)
subplot(2,2,1)
plot(t,X(:,1:3))
legend('X','S','P')
axis([XMIN XMAX YMIN YMAX])
xlabel('Tiempo (h)')
ylabel('Concentracion (g/L)')

subplot(2,2,2)
plot(tt,XX(:,1:3),data_exp(:,1),data_exp(:,2:4),'r*','MarkerSize',3)
legend('X','S','P')
axis([XMIN XMAX YMIN YMAX])
xlabel('Tiempo (h)')
ylabel('Concentracion (g/L)')

subplot(2,2,3)
plot(t,X(:,4))
legend('V')
xlabel('Tiempo (h)')
ylabel('Volumen (L)')

subplot(2,2,4)
plot(tt,XX(:,4),data_exp(:,1),data_exp(:,5),'r*','MarkerSize',3)
legend('V')
xlabel('Tiempo (h)')
ylabel('Volumen (L)')
%% 
clear produci
clear producie
data_exp=xlsread('dataexp2');
Product=data_exp(:,4);
tiempo=data_exp(:,1);
vol=data_exp(:,5);
for i=1:(length(tspan))
 if i==1
     produci(1)=0;
     
 else
    produci(i)=(X(i-1,3)-X(i,3))/(t(i-1)-t(i))*X(i-1,4);
 end
end

for i=1:(length(tiempo))
 if i==1
     producie(1)=0;
 else
     
     producie(i)=(Product(i-1)-Product(i))/(tiempo(i-1)-tiempo(i))*vol(i-1);
 end
end
produci=produci';
producie=producie';

figure(2)
plot(tspan,produci,tiempo, producie)
legend('Optimizado','Experimental')
xlabel('Tiempo (h)')
ylabel('Productividad cantidad de producto (mg/dia)')


clear all
clc

tspan=[0 1];
%Valores iniciales Vr Vp Cavr Cavp nvrp


%Vr=X(1); %Volumen del concentrado
%Vp=X(2); %Volumen del filtrado
%Cavr=X(3); %Concentracion del virus activo en el concentrado
%Cavp=X(4); %Concentracion del virus  activo en el filtrado
%nvrp=X(5); %Concentracion total de virus inactivado

Xo=[1000 1e-10 1.1e3 0 1.1e3];
opts = odeset('NonNegative',1);
[t, X]=ode45(@simviral,tspan,Xo,opts);

total=X(:,3)+X(:,4);

figure(1)
[hAx]=plotyy(t,X(:,3:end),t,X(:,1:2));
grid on
legend('Cvr','Cvp','TotalInact','Vr','Vp')
xlabel('Tiempo (h)')
ylabel(hAx(1),'Particulas virales (U/mL)')
ylabel(hAx(2),'Volumen (mL)')

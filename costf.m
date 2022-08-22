function Prod=costf(var)

global Qs param Cinit 

load ParamTrabajo3param.txt
Qs=var(1);
param(1)=ParamTrabajo3param(1);
param(2)=ParamTrabajo3param(2);
param(3)=var(2);
param(4)=ParamTrabajo3param(3);
param(5)=ParamTrabajo3param(4);
param(6)=ParamTrabajo3param(5);
%Condiciones iniciales
data_exp=xlsread('dataexp');
tspan=data_exp(:,1);
Cinit=data_exp(1,2:5);

%% Para el fedbatch con continuo

[t X]=ode45(@mAb_opti,tspan,Cinit);

%% Funcion objetivo = cantidad final de producto.
if X(23,2)<= 0.5 %Sustrato al final en la alimentacion.
    
    Prod=-X(end,3)*X(end,4);

else

    Prod = 1e6;
end

%% productividad 

%for i=1:(length(tspan)-1)
 %if i==1
  %   produci(1)=0;
 %else
%produci(i)=(X(i,3)-X(i+1,3))/(t(i)-t(i+1))*X(i,4);

 %end
%end
%z=length(produci);
%produci(z+1)=produci(z-1);

%	 Prod = min(-produci); 
	 

end





function [dcdt]=mAb(t,E)

global Qs param

%%vector de estados
x=E(1);
s=E(2);
p=E(3);
v=E(4);
%%parametros
ks=param(1);
umax=param(2);
So=param(3);
Yxs=param(4);
Yxp=param(5);
Yps=param(4)/param(5);
b=param(6);
kd=param(7);

%parametrizacion caudal

if t<=2.7
    Fin=0;
else
    Fin=(100-60)/(12.5-2.7);
end


%%ecuaciones cineticas
u=umax*s/(ks+s);
qp=((u)/Yxp+b);
qs=(u/Yxs+qp*Yps);
%kd1=p*kd;
kd1=kd;



%%balances
dvdt=Fin;
dxdt=((u-kd1)*x*v-Fin*x)/v;
dsdt=(Fin*So-qs*x*v-Fin*s)/v;
dpdt=((qp)*x*v-Fin*p)/v;



%%Vector de salida
dcdt=[dxdt dsdt dpdt dvdt];

dcdt=dcdt';









end
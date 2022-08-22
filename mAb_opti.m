function [dcdt]=mAb_opti(t,E)

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
%parametrizacion caudal
Fin=Qs;


%%ecuaciones cineticas
u=umax*s/(ks+s);
qp=(u/Yxp+b);
qs=(u/Yxs+qp/Yps);




%%balances
dvdt=Fin;
dxdt=(u*x*v-Fin*x)/v;
dsdt=(Fin*So-qs*x*v-Fin*s)/v;
dpdt=(qp*x*v-Fin*p)/v;



%%Vector de salida
dcdt=[dxdt dsdt dpdt dvdt];

dcdt=dcdt';









end
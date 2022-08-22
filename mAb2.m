function [dcdt]=mAb2(t,E)

global Qs So Qo

%%vector de estados
x=E(1);
s=E(2);
p=E(3);
v=E(4);
%%parametros

umax=0.8;
ks=0.0326;
qmax=0.3045;
b=0.6514;
gamma=31.43;

%%ecuaciones cineticas
u=umax*s/(ks +s);
qp=qmax*u/(b + u + gamma*u^2);
qs=0.056*u + 1.28*qp + 2.738e-3;


%parametrizacion caudal
if Qs==1
Fin=0.0329*v;
D=0.0329;
else
Fin=0;
D=0;
end


%%balances
dvdt=Fin;
dxdt=0;
dsdt=0;
dpdt=0;



%%Vector de salida
dcdt=[dxdt dsdt dpdt dvdt];

dcdt=dcdt';
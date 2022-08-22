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

%ec cinerticas
u=umax*s/(ks+s);
qp=((u)/Yxp+b);
qs=(u/Yxs+qp*Yps);
%kd1=p*kd;
kd1=kd;



if Qs==1
    %Qo=v*So*u/Sf;
   Fin=qs*x*v/(So-s);
   %Fin=v*exp(u*t);
    D=Fin/v;
    %%balances
    
    
    dvdt=Fin;
    dxdt=((u-kd)*x-D*x);
    dsdt=(Fin/v*So-qs*x-D*s);
    dpdt=(qp*x-D*p);
    
else
    
    Fin=0;
    D=Fin/v;
    %%balances
    dvdt=Fin;
    dxdt=((u-kd)*x-D*x);
    dsdt=(Fin/v*So-qs*x-D*s);
    dpdt=(qp*x-D*p);
  
   
end

%%Vector de salida
dcdt=[dxdt dsdt dpdt dvdt];
mu=u;
dcdt=dcdt';

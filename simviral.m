function dv=simviral(t,X)

%variasbles de estado

Vr=X(1); %Volumen del concentrado
Vp=X(2); %Volumen del filtrado
Cavr=X(3); %Concentracion del virus activo en el concentrado
Cavp=X(4); %Concentracion del virus  activo en el filtrado
nvrp=X(5); %Concentracion total de virus inactivado

%Parametros
kc=1.33e-6;
k=0.0294;
deltaP=100000;
R=1; %factor de retencion
ki=0.0499;

%Ecuaciones auxiliares

Q=k*deltaP/(1+2*kc*k.^2*deltaP.^2*t)^(1/2);


%% Ecuaciones diferenciales

dvrdt=-Q;
dvpdt=Q;

dcavrdt=(-Cavr*Q*(1-R)-Cavr*ki*Vr-dvrdt*Cavr)/Vr;
%dcavpdt=(-dvpdt*Cavp/Vp);
dcavpdt=(+Cavr*Q*(1-R)-Cavp*ki*Vp-dvpdt*Cavp)/Vp;
dnvrpdt=Cavr*ki*Vr+Cavp*ki*Vp;


dv=[dvrdt dvpdt dcavrdt dcavpdt dnvrpdt ];
dv=dv';


end
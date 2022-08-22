function J=main(parame)

global Qs param Cinit
Qs = 0;
KS=parame(1);
UMAX=parame(2);
SO=parame(3);
YXS=parame(4);
YXP=parame(5);
b=parame(6);
KD=parame(7);

param(1)=KS;
param(2)=UMAX;
param(3)=SO;
param(4)=YXS;
param(5)=YXP;
param(6)=b;
param(7)=KD;

%Condiciones iniciales

data_exp=xlsread('graficas_butanol');
tspan=data_exp(:,1);

%Cinit=data_exp(1,2:5);
Cinit=[0.1   86.1770         0         1];
%% Para el fedbatch con flujo discreto
%opts = odeset('NonNegative',1,'MaxStep',0.1);
[t X]=ode15s(@mAb_opti,tspan,Cinit);


%% Comparacion de datos 
yx=X(:,1);
ys=X(:,2);
yp=X(:,3);
yv=X(:,4);

yx_e=data_exp(:,7);
ys_e=data_exp(:,3);
yp_e=data_exp(:,4);
yv_e=data_exp(:,5);

errX=(yx-yx_e).^2;
errS=(ys-ys_e).^2;
errP=(yp-yp_e).^2;
errV=(yv-yv_e).^2;

pX=1;
pS=1;
pP=1;
pV=0;

J=sum(errX)*pX+sum(errS)*pS+sum(errP)*pP+sum(errV)*pV;
txt=num2str(param,3);

figure(1)
delete(findall(gcf,'Tag','stream'))
plot(t,X(:,1:3),data_exp(:,1),yx_e,'b*',data_exp(:,1),ys_e,'g*',data_exp(:,1),yp_e,'r*')
legend('X','S','P')
t=annotation('textbox', [0.17, 0.84, 0.372, 0.049], 'String', txt,'FitBoxToText','on','Tag','stream');
drawnow;

end



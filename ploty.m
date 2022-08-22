clear all

global param Qs S0


load ParamTrabajo4param.txt

data_exp=xlsread('dataexp');
tspan=[0 data_exp(end,1)];


Cinit=data_exp(1,2:5);

param=ParamTrabajo4param;

ks=param(1);
umax=param(2);
So=param(3);
Yxs=param(4);
Yxp=param(5);
Yps=param(4)/param(5);
b=param(6);
kd=param(7);

opts = odeset('NonNegative',1,'MaxStep',0.1);
[t X]=ode15s(@mAb,tspan,Cinit,opts);

figure(2)
subplot(2,1,1)
plot(t,X(:,1:3),data_exp(:,1),data_exp(:,2:4),'r*')
legend('X','S','P')


subplot(2,1,2)
plot(t,X(:,4),data_exp(:,1),data_exp(:,5),'r*')
legend('V')

for i=1:length(t)
    if i==1
        prod(i)=0;
        u(i)=0;
        qp(i)=0;
    else
        prod(i)=(X(i,3)-X((i-1),3))/(t(i)-t(i-1));
        u(i)=log(X(i,1)*X(i,4)/(X((i-1))*X((i-1),4)))/((t(i)-t(i-1)));
        qp(i)=((u(i))/Yxp+b);
    end
end
        u(1)=u(2);
        qp(1)=qp(2);
        u=u';
        qp=qp';

        [qpmax , index]=max(qp);
        tcrit=t(index);
        
figure(3)
plot(t,[qp u])
legend('qp [gP/gX h]','u [h -1]')
axis([0 14 0 0.6])

%%
Qs=1;
tspan=[0 tcrit];
Cinit(4)=50;
%%%%Corriendo el bath + fedbatch
[to Xo]=ode15s(@mAb,tspan,Cinit,opts);

%%%%empezando el exponencial
Cinit=Xo(end,:);
tspan=[tcrit 14.27];
%param(3)=700;
[te Xe]=ode15s(@mAbexpo,tspan,Cinit,opts);

figure(4)
subplot(2,1,1)
plot(to,Xo(:,1:3),te,Xe(:,1:3))
legend('Xfbatch','Sfbatch','Pfbatch','Xfexp','Sfexp','Pfexp')


subplot(2,1,2)
plot(to,Xo(:,4),te,Xe(:,4))
legend('V')

clear i
for i=1:length(to)
    if i==1
        prodo(i)=0;
        uo(i)=0;
        qpo(i)=0;
    else
        prodo(i)=(Xo(i,3)-Xo((i-1),3))/(to(i)-to(i-1));
        uo(i)=log(Xo(i,1)*Xo(i,4)/(Xo((i-1))*Xo((i-1),4)))/((to(i)-to(i-1)));
        qpo(i)=((uo(i))/Yxp+b);
    end
end
        uo(1)=uo(2);
        qpo(1)=qpo(2);
        uo=uo';
        qpo=qpo';
clear i
for i=1:length(te)
    if i==1
        prode(i)=prodo(end);
        ue(i)=uo(end);
        qpe(i)=qpo(end);
    else
        prode(i)=(Xe(i,3)-Xe((i-1),3))/(te(i)-te(i-1));
        ue(i)=log(Xe(i,1)*Xe(i,4)/(Xe((i-1))*Xe((i-1),4)))/((te(i)-te(i-1)));
        qpe(i)=((ue(i))/Yxp+b);
    end
end
       ue=ue';
        qpe=qpe';
figure(5)
plot(to,[qpo uo],te,[qpe ue])
legend('qpfBatch','ufBatch','qpFexp','uFexp')


Pxbatch=Xe(end,4)*Xe(end,3)/1000;
Batchxanoxreactor=365*0.8/(te(end));
Aproxbatch=ceil(Batchxanoxreactor);
Pxreactorxano=Pxbatch*Aproxbatch;
reactores=1000/Pxreactorxano;
reactoresaprox=ceil(reactores)



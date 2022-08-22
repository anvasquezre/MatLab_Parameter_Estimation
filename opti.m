clear all
clc

%% Valores semilla para los parametros
global S0
ks=5/180*1000;
umax=0.25;
so=0.1;
Yxs=1/1.36;
Yxp=1/0.871;
b=0.05;
kd=1e-3;

paramMi=[ks umax so Yxs Yxp b kd];
Np=length(paramMi)
%% 
tic;

clc ; 
	 LBp = paramMi*1.5;
	 UBp = paramMi*0.5;
     
     
    Lb=[0   0   0     0.1     0.1     0   0 ];
    Ub=[30  3  20   20     3    20   20 ];
	 N = 1; % Number of runs of the optimization algorithm 
	 options1 = optimset('LargeScale','off', 'Diagnostics','on','Display','iter');
	 options2 = optimset('LargeScale','on', 'GradObj','on','Hessian', 'on', 'Display','iter', 'Diagnostics','on');

     alt_optim =1;
	 if alt_optim ==1 
	 options = options1; 
	 else 
	 options = options2; 
	 end 
	 clear i; 
disp('                                       ');
disp('           *********************************** ');
disp('                  Finding the estimates');
disp('           *********************************** ');
	 for i = 1:N 
		  aleat = rand(1,Np);
 		  if i==1
 		  paramo(1,:) = paramMi; 
 		  else 
 		   for j=1:Np  
 		    paramo(i,j) = LBp(j)+aleat(j)*(UBp(j)-LBp(j));  
 		  end 
 		  end 
 	[x(i,:),fval(i), exitflag(i), output,grad,hessian] = fmincon(@main, paramo(i,:),[],[],[],[],Lb,Ub,[],options);
   %[x(i, :), fval(i), exitflag(i), output] = fminsearch(@main, paramo(i,:), options);
   %[x(i, :), fval(i), exitflag(i), output] = patternsearch(@main, paramo(i,:),[],[],[],[],Lb,Ub,[],options);
disp('                                       ');
	 fvalues(i) = fval(i);
	 estimates(i,:) = x(i,:);
     end 
          
 
	 F = sort(fvalues);
	 minfval = min(fvalues); 
	 indexfval = find(fvalues==minfval); 
	 teta = estimates(indexfval,:);
	 Jc = minfval; 
	 teta_estimates = teta;
	 % teta_estimates = exp(teta); % For the case of change in the parameterization 
	 zero_teta = length(find(teta_estimates>=0)); 
	 J_cost = Jc; 

     tiempo = toc;
     
     fileparams = strcat('ParamTrabajo3','param.txt');
fid = fopen(fileparams,'w');
 for k = 1:Np
fprintf(fid,'%s\n',num2str(teta_estimates(k)));
 end 
fclose(fid);

ploty
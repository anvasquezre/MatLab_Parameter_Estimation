clear all

Qs=1;
So=20;
Np=2;
paramMi=[Qs So];
%% 
tic;

clc ; 
	 LBp = paramMi*1.1;
	 UBp = paramMi*0.9;
     
     
    Lb=[0 0];
    Ub=[2 30];
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
		  aleat = rand(1,5);
 		  if i==1
 		  paramo(1,1:Np) = paramMi; 
 		  else 
 		   for j=1:Np  
 		    paramo(i,j) = LBp(j)+aleat(j)*(UBp(j)-LBp(j));  
 		  end 
          end 
          
    %% fminunc
 	%[x(i,:),fval(i), exitflag(i), output,grad,hessian] = fminunc(@costf,paramo(i,:),options);
    
    %% X = fmincon
   %[x(i, :), fval(i), exitflag(i), output] = fmincon(@costf, paramo(i,:),[],[],[],[],Lb,Ub,[],options) ;
   
   %% PatternSearch
   [x(i, :), fval(i), exitflag(i), output] = patternsearch(@costf, paramo(i,:),[],[],[],[],Lb,Ub,[],options);
   %% 
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
     
     fileparams = strcat('alimideal2','opti.txt');
fid = fopen(fileparams,'w');
 for k = 1:Np
fprintf(fid,'%s\n',num2str(teta_estimates(k)));
 end 
fclose(fid);

plot_opti;

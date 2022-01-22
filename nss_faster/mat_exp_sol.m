function [LG_exp,y_t_exp] = mat_exp_sol(p,t)
% function [LG_exp,LG_ode,y_t_exp,y_t_ode] = mat_exp_sol(p,t,TF)
% input: parameters, TF, and a particular time point
% solution to the system of ODE at this particular t

% commented second line can be used to compare with ODE solver

%% assigning constants
Kab= p(1);
Kba = p(2);
Kbd = p(3);
Kdb0 = p(4);
Kcd = p(5);
Kdc = p(6);
Kca0 = p(7);
% Kac = p(8); % neq
% TF = p(9); % neq

Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2)); % eq
TF = p(8); % eq


%% set up the matrix

A = [[-Kab-Kac,Kba,Kca0*TF,0,0,0,0,0];
    [Kab,-Kba-Kbd,0,Kdb0*TF,0,0,0,0];
    [Kac,0,-(Kca0*TF+Kcd),Kdc,0,0,0,0];
    [0,Kbd,Kcd,-(Kdc+Kdb0*TF),0,0,0,0];
    [0,0,Kca0,0,-(Kab+Kac),Kba,Kca0*TF,0];
    [0,0,0,Kdb0,Kab,-(Kba+Kbd),0,Kdb0*TF];
    [0,0,-Kca0,0,Kac,0,-(Kca0*TF+Kcd),Kdc];
    [0,0,0,-Kdb0,0,Kbd,Kcd,-(Kdc+Kdb0*TF)]];

%% initial condition
y0 = [0;0;0;0;0;0;0;0];
[y0(1),y0(2),y0(3),y0(4)] = ss_ic(Kcd,Kdc);

%% matrix exponential solution
y_t_exp = expm(t.*A)*y0;
LG_exp = TF/y_t_exp(1)*y_t_exp(5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% compare to ODE solver
% pars.Kab= p(1);
% pars.Kba = p(2);
% pars.Kbd = p(3);
% pars.Kdb0 = p(4);
% pars.Kcd = p(5);
% pars.Kdc = p(6);
% pars.Kca0 = p(7);
% % Kac = p(8); % neq
% % TF = p(9); % neq
% 
% Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2)) % eq
% TF = p(8); % eq
% 
% y0 = [0;0;0;0;0;0;0;0];
% [y0(1),y0(2),y0(3),y0(4)] = ss_ic(pars.Kcd,pars.Kdc);
% 
% tspan = [0:0.1:t];
% [tpred,ypred] = ode23s(@(t,y) local_sens(t,y,pars,TF),tspan,y0);
% y_t_ode = ypred(end,:);
% LG_ode = TF/y_t_ode(1)*y_t_ode(5);

end

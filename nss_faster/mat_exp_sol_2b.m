function [LG_exp,y_t_exp] = mat_exp_sol_2b(p,t)
% function [LG_exp,LG_ode,y_t_exp,y_t_ode] = mat_exp_sol(p,t,TF)
% input: parameters, TF, and a particular time point
% solution to the system of ODE at this particular t

% commented second line can be used to compare with ODE solver

%% assigning constants
Kab0 = p(1);
Kad0 = p(2);
Kba = p(3);
Kda = p(4);
Kbc0 = p(5);
Kcb = p(6);
Kcd = p(7);
Kdc0 = p(8); % neq
TF = p(9); % neq

% Kdc0 = Kab0*Kbc0*Kcd*Kda/(Kad0*Kba*Kcb); % eq
% TF = p(8); % eq


%% set up the matrix

A = [[-(Kab0*TF+Kad0*TF),Kba,0,Kda,0,0,0,0];
    [Kab0,-(Kba+Kbc0*TF),Kcb,0,0,0,0,0];
    [0,Kbc0*TF,-(Kcb+Kcd),Kdc,0,0,0,0];
    [Kad0*TF,0,Kcd,-(Kdc0*TF+Kda),0,0,0,0];
    [-(Kab0+Kad0),0,0,0,-(Kab0*TF+Kad0*TF),Kba,0,Kda];
    [Kab0,-Kbc0,0,0,Kab0*TF,-(Kba+Kbc0*TTF),Kcb,0];
    [0,Kbc0,0,Kdc0,0,Kbc0*TF,-(Kcb+Kcd),Kdc];
    [Kad0,0,0,-Kdc0,Kad0*TF,0,Kcd,-(Kdc+Kda)]];

%% initial condition
y0 = [1;0;0;0;0;0;0;0];

%% matrix exponential solution
y_t_exp = expm(t.*A)*y0;
LG_exp = TF/y_t_exp(1)*y_t_exp(5);
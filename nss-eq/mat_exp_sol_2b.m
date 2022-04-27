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

TF = p(8); 
Kdc0 = Kab0*TF*Kbc0*TF*Kcd*Kda/(Kad0*TF*Kcb*Kba*TF); 

if Kdc0 < 0.001
    LG_exp = nan;
    y_t_exp = nan;
    return
end 

%% set up the matrix

A = [[-(Kab0*TF+Kad0*TF),Kba,0,Kda,0,0,0,0];
    [Kab0,-(Kba+Kbc0*TF),Kcb,0,0,0,0,0];
    [0,Kbc0*TF,-(Kcb+Kcd),Kdc0*TF,0,0,0,0];
    [Kad0*TF,0,Kcd,-(Kdc0*TF+Kda),0,0,0,0];
    [-(Kab0+Kad0),0,0,0,-(Kab0*TF+Kad0*TF),Kba,0,Kda];
    [Kab0,-Kbc0,0,0,Kab0*TF,-(Kba+Kbc0*TF),Kcb,0];
    [0,Kbc0,0,Kdc0,0,Kbc0*TF,-(Kcb+Kcd),Kdc0*TF];
    [Kad0,0,0,-Kdc0,Kad0*TF,0,Kcd,-(Kdc0*TF+Kda)]];

%% initial condition
y0 = [1;0;0;0;0;0;0;0];

%% matrix exponential solution
y_t_exp = expm(t.*A)*y0;
LG_exp = TF/y_t_exp(1)*y_t_exp(5);
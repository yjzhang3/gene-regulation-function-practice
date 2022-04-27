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
TF = p(8); % eq

Kac = p(1)*p(3)*p(6)*p(7)*p(8)/(p(5)*p(4)*p(8)*p(2)); % eq

if Kac < 0.001
    LG_exp = nan;
    y_t_exp = nan;
    return
end 
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

end
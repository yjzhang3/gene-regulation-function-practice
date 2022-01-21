function [lg_max,x] = psmin_ss(TF)

% input: fixed TF 
% output: parameters that maximizes LG for this fixed TF

%% parameters
niter = 20;
rng default
% lb = zeros(1,8)+1E-2; % neq
lb = zeros(1,7)+1E-2; % eq

% ub = zeros(1,8)+1E+3; % neq
ub =  zeros(1,7)+1E+3; % eq

% nvars = 8; % neq
nvars = 7; % eq

fun = @(p) -1*local_sens_ss(p,TF);

%% particle swarm once
% x = particleswarm(fun,nvars,lb,ub)
% [lg_max,T_max] = lg_TF_nss_v2(x,t,TF)

%% more iterations for particle swarm
lgmax = zeros(niter,1);

% pp = zeros(niter,8); % neq
pp = zeros(niter,7);

parfor iteration = 1:niter
    xx = particleswarm(fun,nvars,lb,ub);
    pp(iteration,:) = xx;
    lg = local_sens_ss(xx,TF);
    lgmax(iteration) = lg;
end

[lg_max,I] = max(lgmax)
x = pp(I,:)


end

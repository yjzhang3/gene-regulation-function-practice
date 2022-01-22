function [lg_max,T_max,x] = psmin_nss_v2(TF,t)
% input: fixed TF and t for simulation
% output: parameters that maximizes LG

%% parameters
niter = 20;
rng default
% lb = zeros(1,8)+1E-2; % neq
lb = zeros(1,7)+1E-2; % eq

% ub = zeros(1,8)+1E+3; % neq
ub =  zeros(1,7)+1E+3; % eq

fun = @(p) -1*lg_TF_nss_v4(p,t,TF);

% nvars = 8; % neq
nvars = 7; % eq

%% particle swarm once
% x = particleswarm(fun,nvars,lb,ub)
% [lg_max,T_max] = lg_TF_nss_v2(x,t,TF)

%% more iterations for particle swarm
lgmax = zeros(niter,1);
Tmax = zeros(niter,1);
% pp = zeros(niter,8); % neq
pp = zeros(niter,7);
% parfor iteration = 1:niter
parfor iteration = 1:niter
    xx = particleswarm(fun,nvars,lb,ub);
    pp(iteration,:) = xx;
    [lg,maxT] = lg_TF_nss_v4(xx,t,TF);
    lgmax(iteration) = lg;
    Tmax(iteration) = maxT;
end

[lg_max,I] = max(lgmax)
T_max = Tmax(I)
x = pp(I,:)


end

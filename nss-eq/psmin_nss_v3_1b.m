function [lg_max,x] = psmin_nss_v3_1b(lbn,ubn,t)
% input: fixed  t for simulation
% output: parameters and TF that maximizes LG

%% parameters
niter = 5;
rng default

lb = zeros(1,8)+lbn; % eq

ub =  zeros(1,8)+ubn; % eq

fun = @(p) -1*lg_TF_nss_v4_1b(p,t);

nvars = 8; % eq

%%
% x = particleswarm(fun,nvars,lb,ub)
% [lg_max,T_max] = lg_TF_nss_v3(x,t)

%% more iterations for particle swarm
lgmax = zeros(niter,1);
pp = zeros(niter,8);

parfor iteration = 1:niter
    xx = particleswarm(fun,nvars,lb,ub);
    pp(iteration,:) = xx;
    lg = -1*fun(xx,t);
    lgmax(iteration) = lg;
    create_parameter_file('nss_eq_1b_results.txt', xx, lg)
end

[lg_max,I] = max(lgmax);
x = pp(I,:);



end
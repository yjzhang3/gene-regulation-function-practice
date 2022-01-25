function [lg_max,T_max,TF_max] = psmin_nss_v2_fixK(p,t)
% input: fixed K and t for simulation
% output: TF that maximizes LG

%% parameters
niter = 20;

rng default
lb = 1E-2;
ub = 1E+3; 

% fun = @(TF) -1*lg_TF_v2(p,t,TF); % using old ODE solver
fun = @(TF) -1*lg_TF_nss_v4_fixK(p,t,TF);
nvars = 1; 

% %% find TF_max that maximizes the log gain at this parameter set
% TF_max = particleswarm(fun,nvars,lb,ub)
% 
% % fixing TF and k and given the maxTF, at what time point is LG maximized
% [lg_max,T_max] = lg_TF_nss_v2(p,t,TF_max)

%% more iterations, not just once
lgmax = zeros(niter,1);
Tmax = zeros(niter,1);
ttff = zeros(niter,1);
parfor iteration = 1:niter
    xx = particleswarm(fun,nvars,lb,ub);
    ttff(iteration) = xx;
    [lg,maxT] = lg_TF_nss_v4_fixK(p,t,xx);
    lgmax(iteration) = lg;
    Tmax(iteration) = maxT;
end

[lg_max,I] = max(lgmax)
T_max = Tmax(I)
TF_max = ttff(I,:)



end

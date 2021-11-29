function [lg,x] = psmin_nss(TF,t)
% output largest log gain as well as the set of parameters that make it
rng default
lb = [1E-2,1E-2,1E-2,1E-2,1E-2,1E-2,1E-2,1E-2];
ub = [1E3,1E3,1E3,1E3,1E3,1E3,1E3,1E3];
fun = @(p) fit_model_nss(p,t,TF);
nvars = 8;
x = particleswarm(fun,nvars,lb,ub)
%% particle swarm results
lg = lg_TF_nss(x,t,TF)
end

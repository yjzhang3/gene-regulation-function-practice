function [lg,p] = psmin_nss(TF,t)
% output largest log gain as well as the set of parameters that make it
rng default
lb = [1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5];
ub = [2,2,2,2,2,2,2,2,2];
fun = @(p) fit_model_nss(p,t,TF);
nvars = 9;
x = particleswarm(fun,nvars,lb,ub);
%% particle swarm results
lg = lg_TF_nss(x,t,TF);
p = x;
end

function lg = psmin_nss(TF,t)
rng default
lb = [1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5];
ub = [2,2,2,2,2,2,2,2,2];
fun = @(p) fit_model_nss(p,t,TF);
nvars = 9;
x = particleswarm(fun,nvars,lb,ub);
%% particle swarm results
lg = lg_TF_nss(x,t,TF);
end
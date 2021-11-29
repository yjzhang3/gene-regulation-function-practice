function [lg,x] = psmin_ss(TF)
rng default
% lb = [1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5];
lb = [1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5];
% ub = [20,20,20,20,20,20,20,20,20];
ub = [20,20,20,20,20,20,20,20];
fun = @(p) fit_model_ss(p,TF);
% nvars = 9;
nvars = 8;
x = particleswarm(fun,nvars,lb,ub)
%% particle swarm results
lg = lg_TF_ss(x,TF)
end

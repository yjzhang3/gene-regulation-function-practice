% find k and production rate that maximizes log gain for non-steady state

%% fmincon
time = 10;
TF = 10; 
[fit, score] = fmincon(@(p) fit_model_nss(p,time,TF),[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01], [],[],[],[],[1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5],[2,2,2,2,2,2,2,2,2]);

%%
maxLG_fmin = lg_TF_nss(fit,10,10);

%% particle swarm
rng default
time = 10;
TF = 10;
fun = @(p) fit_model_nss(p,time,TF);
nvars = 9;
x = particleswarm(fun,nvars);

%% latin hypercube sampling
time = 10;
TF = 10;
maxLG_lhs = 0;
for tt = 1:500
    p = lhsdesign(1,9);
    lg = lg_TF_nss(p,time,TF);
    if lg > maxLG_lhs
        maxLG_lhs = lg;
    end
end
maxLG_lhs
    

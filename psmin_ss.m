function [lg_max,TF_max,x] = psmin_ss(TF)
rng default
lb = zeros(1,8)+1E-2; % neq
% lb = zeros(1,7)+1E-5; % eq
ub = zeros(1,8)+1E+4; % neq
% ub =  zeros(1,7)+1E+4; % eq
fun = @(p) fit_model_ss(p,TF);
nvars = 8; % neq
% nvars = 7; % eq

%% more iterations, not just once
lg_max = 0;
TF_max = 0;
for iteration = 1:300
    x = particleswarm(fun,nvars,lb,ub)
    [lg,TF] = lg_TF_ss(x,TF);
    if lg>lg_max
        lg_max = lg;
        TF_max = TF;
    end
end

end

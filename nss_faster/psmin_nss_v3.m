function [lg_max,T_max,x] = psmin_nss_v3(t)
% input: fixed  t for simulation
% output: parameters and TF that maximizes LG

%% parameters
rng default
lb = zeros(1,9)+1E-2; % neq
% lb = zeros(1,7)+1E-5; % eq

ub = zeros(1,9)+1E+3; % neq
% ub =  zeros(1,7)+1E+4; % eq

fun = @(p) fit_model_nss_v3(p,t);

nvars = 9; % neq
% nvars = 7; % eq

%%
x = particleswarm(fun,nvars,lb,ub)
[lg_max,T_max] = lg_TF_nss_v3(x,t)
%% more iterations, not just once
% lgmax = zeros(10,1);
% TFmax = zeros(10,1);
% parfor iteration = 1:10
%     x = particleswarm(fun,nvars,lb,ub)
%     [lg,maxTF] = lg_TF_nss(x,t,TF);
%     lgmax(iteration) = lg;
%     TFmax(iteration) = maxTF;
% end
% [lg_max,I] = max(lgmax);
% TF_max = TFmax(I);



end

%% find best log gain and parameters for non-steady state
% unknown include: TF, t, and all k
tspan = 5; 
lb = 0.001;
ub = 1000;
[lg_max_1b,x_1b] = psmin_nss_v3_1b(lb,ub,tspan);
[lg_max_2b,x_2b] = psmin_nss_v3_2b(lb,ub,tspan);
save('results.mat','lg_max_1b','x_1b','lg_max_2b','x_2b')
%% plot and verify max LG using best Ks and TF
% now cancel the comment
% tspan = 5;
% lg_TF_nss_v4(x,tspan);





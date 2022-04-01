%% find best log gain and parameters for non-steady state
% unknown include: TF, t, and all k

[lg_max,x] = psmin_nss_v3(0.001,1000,5);

%% plot and verify max LG using best Ks and TF
% now cancel the comment
tspan = T_test;
lg_TF_nss_v4(p_arr,tspan);





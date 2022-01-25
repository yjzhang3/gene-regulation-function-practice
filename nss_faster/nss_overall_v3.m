%% find best log gain and parameters for non-steady state given particular TF
% remember to comment out figure section
T_test = [10];
[LG_arr,p_arr,maxT_arr] = main_nss_v3(T_test);

%% plot and verify max LG using best Ks and TF
% now cancel the comments
for ii = 1:length(T_test)
    lg_TF_nss_v4(p_arr,T_test(ii));
end



%% find best log gain and parameters for non-steady state
% remember to comment out figure section
TF_test = [1,35];
T_test = [2,15];
[LG_arr_ps,p_arr_ps,maxTF_arr] = main_nss(TF_test,T_test);

%% graph TR vs. TF, 
% now cancel the comments
for ii = 1:length(TF_test)
    lg_TF_ss(p_arr_ps(ii,:),TF_test(ii))
end

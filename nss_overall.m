%% find best log gain and parameters for non-steady state
% remember to comment out figure section
TF_test = [1000];
T_test = [15];
[LG_arr_ps,p_arr_ps,maxTF_arr] = main_nss(TF_test,T_test);

%% 
% now cancel the comments
for ii = 1:length(TF_test)
    lg_TF_nss(p_arr_ps(ii,:),T_test(ii),TF_test(ii));
end

%% 
for ii = 1:length(TF_test)
    lg_t_fixTF_v2(TF_test(ii),T_test(ii),p_arr_ps(ii,:));
end 
%% find best log gain and parameters for steady state
% remember to comment out figure section
TF_test = [1000,10000];
[LG_arr_ps,p_arr_ps,maxTF_arr] = main_ss(TF_test);

%% graph TR vs. TF, 
% now cancel the comments
for ii = 1:length(TF_test)
    lg_TF_ss(p_arr_ps(ii,:),TF_test(ii))
end


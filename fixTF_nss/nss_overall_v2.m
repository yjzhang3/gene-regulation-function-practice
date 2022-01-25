%% find best log gain and parameters for non-steady state given particular TF
% remember to comment out figure section
tic
TF_test = [0.01:0.01:1];
T_test = 5; % the system approaches steady state definitely within 10 unit of time
[LG_arr_ps,p_arr_ps,maxT_arr] = main_nss_v2(TF_test,T_test);
toc
%% plot and verify max LG using best Ks
% now cancel the comments
for ii = 1:length(TF_test)
    for jj = 1:length(T_test)
        lg_TF_nss_v4(p_arr_ps(ii,jj,:),T_test,TF_test(ii));
        hold on
    end 
end
%% find the largest among these optimization and focus on them
[B,I] = maxk(LG_arr_ps,9);
p_new = p_arr_ps(I,1,:);
TF_new = TF_test(I);
%% find best k for this set of TF in a steady state system
TF_test = [0.5,1];

[LG_arr,p_arr] = main_ss(TF_test);

%% graph TF and their corresponding LG
plot(TF_test,LG_arr)
xlabel('TF')
ylabel('LG in TR v. TF')

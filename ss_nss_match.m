% get the maximum log gain, what TF maximizes the log gain, and the
% parameters
cd steady_state
[LG_arr_ps,p_arr_ps,maxTF_arr] = main_ss(50)

cd ../

cd nss
% using the same TF and parameters, see if transient response approaches
% the same log gain and what is the shape of the transient curve
maxLG = lg_t_fixTF(maxTF_arr,200,p_arr_ps)

cd ../


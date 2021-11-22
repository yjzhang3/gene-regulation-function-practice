% get the maximum log gain, what TF maximizes the log gain, and the
% parameters

TFmax = 1.2;
Tmax = 100;

[LG_arr_ps,p_arr_ps,maxTF_arr] = main_nss(TFmax,Tmax)


% using the same TF and parameters, see if transient response approaches
% the same log gain and what is the shape of the transient curve
maxLG = lg_t_fixTF(maxTF_arr(1,1),Tmax,p_arr_ps(1,1))

cd ../


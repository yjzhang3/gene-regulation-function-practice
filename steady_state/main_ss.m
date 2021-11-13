function [LG_arr_fmin,LG_arr_lhs,LG_arr_ps] = main_ss(TF_arr)
% find k and production rate that maximizes log gain for steady state

LG_arr_fmin = zeros(length(TF_arr),1);
LG_arr_lhs = zeros(length(TF_arr),1);
LG_arr_ps = zeros(length(TF_arr),1);

for ii = 1:length(TF_arr)
    % latin hypercube sampling 
    ss_maxLG_lhs = lhsmax_ss(100,TF_arr(ii));
    LG_arr_lhs(ii) = ss_maxLG_lhs;
    
    % fmincon
    [fit, score] = fmincon(@(p) fit_model_ss(p,TF_arr(ii)),[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01], [],[],[],[],[1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5],[2,2,2,2,2,2,2,2,2]);
    ss_maxLG_fmin = lg_TF_ss(fit,TF_arr(ii));
    LG_arr_fmin(ii) = ss_maxLG_fmin;
    
    % particle swarm
    ss_maxLG_ps = psmin_ss(TF_arr(ii));
    LG_arr_ps(ii) = ss_maxLG_ps;
end 

end 


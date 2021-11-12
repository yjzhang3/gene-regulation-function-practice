function [LG_arr_fmin,LG_arr_lhs,LG_arr_ps] = main_nss(TF_arr,t_arr)
% find k and production rate that maximizes log gain for steady state

LG_arr_fmin = zeros(length(TF_arr),length(t_arr));
LG_arr_lhs = zeros(length(TF_arr),length(t_arr));
LG_arr_ps = zeros(length(TF_arr),length(t_arr));

for ii = 1:length(TF_arr)
    for jj = 1:length(t_arr)
        % latin hypercube sampling 
        nss_maxLG_lhs = lhsmax_nss(100,TF_arr(ii),t_arr(jj));
        LG_arr_lhs(ii,jj) = nss_maxLG_lhs;
    
        % fmincon
        [fit, score] = fmincon(@(p) fit_model_nss(p,t_arr(jj),TF_arr(ii)),[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01], [],[],[],[],[1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5],[2,2,2,2,2,2,2,2,2]);
        nss_maxLG_fmin = lg_TF_nss(fit,t_arr(jj),TF_arr(ii));
        LG_arr_fmin(ii,jj) = nss_maxLG_fmin;

        % particle swarm
        nss_maxLG_ps = psmin_nss(TF_arr(ii),t_arr(jj));
        LG_arr_ps(ii,jj) = nss_maxLG_ps;
    end
end 

end 


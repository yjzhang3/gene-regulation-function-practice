function [LG_arr_ps,p_arr_ps,maxT_arr] = main_nss_v2(TF_arr,t_arr)
% find k and production rate that maximizes log gain for steady state
% TF_arr is array of specific TF, but t_arr is an array of upper bound of
% simulation time

% LG_arr_fmin = zeros(length(TF_arr),length(t_arr));
% LG_arr_lhs = zeros(length(TF_arr),length(t_arr));
LG_arr_ps = zeros(length(TF_arr),length(t_arr));

p_arr_ps = zeros(length(TF_arr),length(t_arr),8); % neq
% p_arr_ps = zeros(length(TF_arr),length(t_arr),7); % eq
% each row is the best set of k for a particular TF range and t range

% what is the time that maximizes at this particular TF 
maxT_arr = zeros(length(TF_arr),1); 


for ii = 1:length(TF_arr)
    for jj = 1:length(t_arr)
%         % latin hypercube sampling 
%         nss_maxLG_lhs = lhsmax_nss(100,TF_arr(ii),t_arr(jj));
%         LG_arr_lhs(ii,jj) = nss_maxLG_lhs;
%     
%         % fmincon
%         [fit, score] = fmincon(@(p) fit_model_nss(p,t_arr(jj),TF_arr(ii)),[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01], [],[],[],[],[1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5],[2,2,2,2,2,2,2,2,2]);
%         nss_maxLG_fmin = lg_TF_nss(fit,t_arr(jj),TF_arr(ii));
%         LG_arr_fmin(ii,jj) = nss_maxLG_fmin;

        % particle swarm
        [nss_maxLG_ps,nss_maxT_ps,p] = psmin_nss_v2(TF_arr(ii),t_arr(jj));
        LG_arr_ps(ii,jj) = nss_maxLG_ps;
        p_arr_ps(ii,jj,:) = p;
        maxT_arr(ii) = nss_maxT_ps;
    end
end 

end 


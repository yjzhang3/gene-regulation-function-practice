function [LG_arr_ps,p_arr_ps,maxTF_arr] = main_ss(TF_arr)
% find k and production rate that maximizes log gain for steady state
% TF_arr is confusing, basically an array of maximum value (range), which
% means we can test different TF ranges

LG_arr_ps = zeros(length(TF_arr),1);
% LG_arr_lhs = zeros(length(TF_arr),1);
% LG_arr_ps = zeros(length(TF_arr),1);
p_arr_ps = zeros(length(TF_arr),8); % each row is the best set of k for a particular TF range
% p_arr_ps = zeros(length(TF_arr),7);
maxTF_arr = zeros(length(TF_arr),1); % what is the TF that maximizes this particular TF range

for ii = 1:length(TF_arr)
%     % latin hypercube sampling 
%     ss_maxLG_lhs = lhsmax_ss(100,TF_arr(ii));
%     LG_arr_lhs(ii) = ss_maxLG_lhs;
%     
%     % fmincon
%     [fit, score] = fmincon(@(p) fit_model_ss(p,TF_arr(ii)),[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01], [],[],[],[],[1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5],[2,2,2,2,2,2,2,2,2]);
%     ss_maxLG_fmin = lg_TF_ss(fit,TF_arr(ii));
%     LG_arr_fmin(ii) = ss_maxLG_fmin;
%     
    % particle swarm
    [ss_maxLG_ps,ss_maxTF_ps,p] = psmin_ss(TF_arr(ii));
    LG_arr_ps(ii) = ss_maxLG_ps;
    p_arr_ps(ii,:) = p;
    maxTF_arr(ii) = ss_maxTF_ps;
end 

end 


function [LG_arr,p_arr,maxT_arr] = main_nss_v2(TF_arr,t_arr)
% find k that maximizes log gain for non steady state
% TF_arr is array of specific TF, but t_arr is an array of upper bound of
% simulation time

LG_arr = zeros(length(TF_arr),length(t_arr));

% p_arr = zeros(length(TF_arr),length(t_arr),8); % neq
p_arr_ps = zeros(length(TF_arr),length(t_arr),7); % eq
% each row is the best set of k for a particular TF range and t range

% what is the time that maximizes at this particular TF 
maxT_arr = zeros(length(TF_arr),1); 


for ii = 1:length(TF_arr)
    for jj = 1:length(t_arr)
        % particle swarm
        [nss_maxLG,nss_maxT,p] = psmin_nss_v2(TF_arr(ii),t_arr(jj));
        LG_arr(ii,jj) = nss_maxLG;
        p_arr(ii,jj,:) = p;
        maxT_arr(ii) = nss_maxT;
    end
end 

end 


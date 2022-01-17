function [LG_arr,p_arr] = main_ss(TF_arr)
% find k maximizes log gain for steady state
% TF_arr is array of specific TF, but t_arr is an array of upper bound of
% simulation time

LG_arr = zeros(length(TF_arr),1);

% p_arr = zeros(length(TF_arr),8); % neq
p_arr_ps = zeros(length(TF_arr),7); % eq
% each row is the best set of k for a particular TF range and t range

for ii = 1:length(TF_arr)
    % particle swarm
    [ss_maxLG,p] = psmin_ss(TF_arr(ii));
    LG_arr(ii) = ss_maxLG;
    p_arr(ii,:) = p;
end 

end 


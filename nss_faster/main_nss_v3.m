function [LG_arr,p_arr,maxT_arr] = main_nss_v3(t_arr)
% find k and TF that maximizes log gain for non steady state
% t is total simulation time (can give multiple values)

LG_arr = zeros(length(t_arr),1);

p_arr = zeros(length(t_arr),9); % neq
% p_arr = zeros(length(t_arr),8); % eq
% each row is the best set of k and TF for this simulation range

% what is the time that maximizes at this particular TF and k
maxT_arr = zeros(length(t_arr),1); 

for jj = 1:length(t_arr)
    % particle swarm
    [nss_maxLG,nss_maxT,p] = psmin_nss_v3(t_arr(jj));
    LG_arr(jj) = nss_maxLG;
    p_arr(jj,:) = p;
    maxT_arr(jj) = nss_maxT;
end


end 


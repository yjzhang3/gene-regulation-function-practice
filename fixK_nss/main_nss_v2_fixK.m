function [maxLG_arr,maxTF_arr,maxT_arr] = main_nss_v2_fixK(p,t)
% find k and production rate that maximizes log gain for steady state
% TF_arr is array of specific TF; t is the upper bound of
% simulation time

% store max LG at different parameter set p
maxLG_arr = zeros(length(p(:,1)),1);

% store TF that maximizes the LG
maxTF_arr = zeros(length(p(:,1)),1);

% what is the time that maximizes at this particular TF 
maxT_arr = zeros(length(p(:,1)),1); 

for ii = 1:length(p(:,1))
    % particle swarm
    [nss_maxLG,nss_maxT,nss_maxTF] = psmin_nss_v2_fixK(p(ii,:),t);
    maxLG_arr(ii) = nss_maxLG;
    maxT_arr(ii) = nss_maxT;
    maxTF_arr(ii) = nss_maxTF;
end 

end 


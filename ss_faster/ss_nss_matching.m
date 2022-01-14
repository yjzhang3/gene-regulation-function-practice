%% if reshape needed
p = reshape(p_arr_ps(30,1,:),[1,8]); % this ia some parameters optimized
% from non steady state
%% verify if quasi steady state = steady state 
lg_ss_overall = zeros(1,length(p(:,1)));
for ll = 1:length(p(:,1))
    lg_ss = local_sens_ss(p(ll,:),maxTF_arr(ll));
    % maxTF_arr is also found from non-steady state. A list of TF that
    % maximizes LG for this particular reaction rate
    
    lg_ss_overall(ll) = lg_ss;
    % store all quasi steady state into an array
end
%%
scatter(maxTF_arr,lg_ss_overall')
xlabel("TF")
ylabel("LG")
set(gca,"FontSize",13)
title("steady state LG for TF that results in 9 largest transient log gain")
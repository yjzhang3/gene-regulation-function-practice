%% if reshape needed
p = reshape(p_arr_ps(30,1,:),[1,8]);
%% verify if quasi steady state = steady state 
lg_ss_overall = zeros(1,length(p_new(:,1,1)));
for ll = 1:length(p_new(:,1,1))
    lg_ss = local_sens_ss(p(ll,:),maxTF_arr(ll));
    lg_ss_overall(ll) = lg_ss;
end
%%
scatter(maxTF_arr,lg_ss_overall')
xlabel("TF")
ylabel("LG")
set(gca,"FontSize",13)
title("steady state LG for TF that results in 9 largest transient log gain")
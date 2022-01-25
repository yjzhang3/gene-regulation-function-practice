function [maxLG,maxT,LG_overall] = lg_TF_nss_v4(p,t)
% TF is also a parameter to run 
% same as lg_TF_nss_v4, but using matrix exponential to estimate solution
% input: parameters and simulation time (upper bound)
% different from v2, TF is packed into the vector of parameters
% output: the log gain in TR w.r.t this TF over time

tspan = [0.1:0.1:t];

for tt = 1:length(tspan)
    [LG,y] = mat_exp_sol(p,tspan(tt));
    LG_overall(tt) = LG;
end

[maxLG,I] = max(LG_overall);
maxT = tspan(I);

%% plot
plot(tspan,LG_overall)
xlabel('time')
ylabel('log gain in TR wrt TF')

end




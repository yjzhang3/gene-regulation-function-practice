function [maxLG,maxT,LG_overall] = lg_TF_nss_v4_fixK(p,t,TF)
% same as lg_TF_nss_v2, but using matrix exponential to estimate solution
% input: parameters and simulation time (upper bound)

% output: the log gain in TR w.r.t this TF over time

tspan = [0.1:0.1:t];

for tt = 1:length(tspan)
    [LG,y] = mat_exp_sol(p,tspan(tt),TF);
    LG_overall(tt) = LG;
end

[maxLG,I] = max(LG_overall);
maxT = tspan(I);

%% plot
plot(tspan,LG_overall);
xlabel('time')
ylabel('log gain in TR wrt TF')
% spec2 = sprintf('quasi steady state LG at TF = %0.5f approaches %0.5f',TF,LG(end));
% yline(LG(end),'-',spec2,'LineWidth',3,'Color',[0.1 0.9 0.2])
end




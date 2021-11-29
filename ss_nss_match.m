%% compute max LG, best set of parameters, and TF that maximizes this LG 
TFmax = [0.1,1,10];
Tmax = 2;
% 
% [LG_arr_ps,p_arr_ps,maxTF_arr] = main_nss(TFmax,Tmax)
% [LG_arr_ps,p_arr_ps,maxTF_arr] = main_nss([0.1,1,10],2)


%% generate graphs
for gg = 1:length(LG_arr_ps)
    match_graph(LG_arr_ps(gg),p_arr_ps(gg,1,:),maxTF_arr(gg),Tmax*5);
end

%% auxillary function

function nt = match_graph(LG_arr_ps,p_arr_ps,maxTF_arr,Tmax)
% this function generates graphs that match steady state and non steady
% state. It only takes a single value LG, P, and maxTF!!

% compute the log gain at the same TF 
% the function lg_TF_ss can give an array of log gains and find what is log
% gain at TF that maximizes nss log gain

% uncomment the graph section of lg_TF_ss!!
[lg,tf,lg_ss_arr] = lg_TF_ss(p_arr_ps,maxTF_arr);
spec1 = sprintf('steady state LG at TF = %0.5f is %0.5f', maxTF_arr,lg_ss_arr(end));
yline(lg_ss_arr(end),'--',spec1,'LineWidth',3,'Color',[0.5 0 0.8])


% using the same TF and parameters, see if transient response approaches
% the same log gain and what is the shape of the transient curve
figure();
[maxLG,lg_nss_arr] = lg_t_fixTF(maxTF_arr,Tmax*5,p_arr_ps);
spec1 = sprintf('steady state LG at TF = %0.5f is %0.5f',maxTF_arr,lg_ss_arr(end));
yline(lg_ss_arr(end),'--',spec1,'LineWidth',3,'Color',[0.5 0 0.8])

figure();
[maxLG,lg_nss_arr] = lg_t_fixTF(maxTF_arr,Tmax*5,p_arr_ps);
spec2 = sprintf('non steady state LG at TF = %0.5f approaches %0.5f',maxTF_arr,lg_nss_arr(end));
yline(lg_nss_arr(end),':',spec2,'LineWidth',3,'Color',[0.1 0.9 0.2])

nt = 1; % successfully compiled, return 1
end 
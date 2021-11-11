function abs_maxLG = lg_TF_nss(p,time,TF)
% 
% time = 100;
% TF = 15;
% p = [0.9,0.78,0.54,0.3,0.03,0.02,0.01,0.07,0.1];
% set up model parameters (these will be fed into ODE solver)
pars.Kab= p(1);
pars.Kba = p(2);
pars.Kbd = p(3);
pars.Kdb0 = p(4);
pars.Kcd = p(5);
pars.Kdc = p(6);
pars.Kca0 = p(7);
pars.Kac = p(8);
prod_rate = p(9);

% initial condition
y0 = [0;0;0;1]; % start with unoccupied, inactive
    
% try all possible TF concentration and simulate for designated seconds
TF_span = [0.1:0.1:TF]; 
tspan = [0.1:0.1:time];
TR_all = zeros(length(tspan),1); % store time dependent TR for each unique TF
% size(TR_all)

[t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,3),tspan,y0);

% simulate model
for jj = 1:length(TF_span)
    [t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF_span(jj)),tspan,y0);
    TR_all = cat(2,TR_all,transcription_rate_ss(y_pred(:,1),prod_rate));
%     size(TR_all)
end
TR_all(:,1) = [];
% size(TR_all)

% calculate log gain for each time point at each TF
LG_all_t = zeros(1,length(TF_span));
for gg = 1:length(tspan)
    log_gain = gradient(log(TR_all(gg,:))) ./ gradient(log(TF_span));
    LG_all_t = cat(1,LG_all_t,log_gain);
end
LG_all_t(1,:) = [];

% find the max log gain among all TF, all time
abs_maxLG = max(LG_all_t(:));
abs_maxLG
% % plot what is the max LG for each time point
% max_LG_t = [];
% for tt = 1:length(tspan)
%     max_LG_t = [max_LG_t,max(LG_all_t(tt,:))];
% end
% % 
% figure();
% plot(tspan,max_LG_t,"LineWidth",4)
% xlabel("time")
% ylabel("maximum log gain in TR/TF")
% title("maximum log gain of TR/TF, time dependent")
% set(gca,"FontSize",13)

    
    
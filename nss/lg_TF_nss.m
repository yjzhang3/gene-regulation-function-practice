function [abs_maxLG,LG_all] = lg_TF_nss(p,time,TF)
% calculate maximum log gain for a transient system while varying TF
% concentration

% 
% time = 5;
% TF = 0.8;
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
TF_span = [0:0.01:TF]; 
tspan = [0:0.01:time];
TR_all = zeros(length(tspan),length(TF_span)); % store time dependent TR for each unique TF
% size(TR_all)

% [t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,3),tspan,y0);
% TR = transcription_rate_ss(y_pred(:,1),prod_rate);
% options = odeset('RelTol',1e-7,'AbsTol',1e-8);

% simulate model
parfor jj = 1:length(TF_span)
    [t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF_span(jj)),tspan,y0);
    TR_all(:,jj) = transcription_rate_ss(y_pred(:,1),prod_rate);
%     size(TR_all)
end

% 
% calculate log gain for each time point at each TF
LG_all = zeros(length(tspan),length(TF_span));
parfor gg = 1:length(tspan)
    log_gain = gradient(log(TR_all(gg,:))) ./ gradient(log(TF_span));
    LG_all(gg,:) = log_gain;
end

% find the max log gain among all TF, all time
abs_maxLG = max(LG_all(:));

% % plot what is the max LG for each time point
% max_LG_t = [];
% for tt = 1:length(tspan)
%     max_LG_t = [max_LG_t,max(LG_all(tt,:))];
% end
% 
% figure();
% plot(tspan,max_LG_t,"LineWidth",4)
% xlabel("time")
% ylabel("maximum log gain in TR/TF")
% title("maximum log gain of TR/TF, time dependent")
% set(gca,"FontSize",13)

% % plot what is the max LG for each TF 
% max_LG_TF = [];
% for ff = 1:length(TF_span)
%     max_LG_TF = [max_LG_TF,max(LG_all(:,ff))];
% end

% figure();
% plot(TF_span,max_LG_TF,"LineWidth",4)
% xlabel("TF")
% ylabel("maximum log gain in TR/TF")
% title("maximum log gain of TR/TF, TF dependent")
% set(gca,"FontSize",13)
    
    

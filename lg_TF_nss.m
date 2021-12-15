function [abs_maxLG,maxTF] = lg_TF_nss(p,time,TF)
% calculate maximum log gain for a transient system while varying TF
% concentration

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
pars.Kac = p(8); % neq
% pars.Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2)); % eq


% initial condition
y0 = [0;0;0;1]; % start with unoccupied, inactive
    
% try all possible TF concentration and simulate for designated seconds
TF_span = [0:1:TF]; 
tspan = [0:0.01:time];
TR_all = zeros(length(tspan),length(TF_span)); % store time dependent TR for each unique TF
% size(TR_all)

% [t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,3),tspan,y0);
% TR = transcription_rate_ss(y_pred(:,1),prod_rate);
% options = odeset('RelTol',1e-7,'AbsTol',1e-8);

% simulate model
for jj = 1:length(TF_span)
    [t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF_span(jj)),tspan,y0);
    TR_all(:,jj) = transcription_rate_ss(y_pred(:,1),1); % assume prod_rate = 1
%     size(TR_all)
end
% each entry in y_pred is the TF at that particular TF and time, not for a
% range of TF or a range of time

% 
% calculate log gain for each time point at each TF
LG_all = zeros(length(tspan),length(TF_span));
for gg = 1:length(tspan)
    log_gain = gradient(log(TR_all(gg,:))) ./ (gradient(log(TF_span)));
    LG_all(gg,:) = log_gain;
end

% find the max log gain among all TF, all time
abs_maxLG = max(LG_all(:))
% find TF that maximizes LG
[i,j] = find(LG_all==abs_maxLG);
maxTF = TF_span(j);
maxT = tspan(i);

% what is the max LG for each time point, and find the TF at each time
% point that maximizes the log gain
max_LG_t = [];
for tt = 1:length(tspan)
    max_LG_t = [max_LG_t,max(LG_all(tt,:))];
end

% make sure to comment this out when running main to decrease run time
figure();
subplot(2,1,1)
plot(tspan,max_LG_t,"LineWidth",4)
xlabel("time")
ylabel("max LG among all possible TFs, fixing time")
title("maximum log gain of TR/TF, time dependent")
%spec1 = sprintf('max LG at t = %0.5f among all TF is %0.5f', tspan(500),max_LG_t(500));
spec3 = sprintf('absolute max LG is %0.5f at T = %0.5f',abs_maxLG,maxT);
% 
% % a sample point on the graph
% xline(tspan(500),'--','LineWidth',3,'Color',[0.5 0.3 0.8])
% yline(max_LG_t(500),'--',spec1,'LineWidth',3,'Color',[0.5 0.3 0.8])

% absolute max on the graph
xline(maxT,'--','LineWidth',3,'Color',[1 0 0])
yline(abs_maxLG,'--',spec3,'LineWidth',3,'Color',[1 0 0])
set(gca,"FontSize",13)

% % plot what is the max LG for each TF 
max_LG_TF = [];
for ff = 1:length(TF_span)
    max_LG_TF = [max_LG_TF,max(LG_all(:,ff))];
end

subplot(2,1,2)
plot(TF_span,max_LG_TF,"LineWidth",4)
xlabel("TF")
ylabel("max LG among all possible time points, fixing TF")
title("maximum log gain of TR/TF, TF dependent")
% spec2 = sprintf('max LG at TF = %0.5f among all time points is %0.5f', TF_span(500),max_LG_TF(500));
spec4 = sprintf('absolute max LG is %0.5f at TF = %0.5f',abs_maxLG,maxTF);

% % sample
% xline(TF_span(500),'--','LineWidth',3,'Color',[0.5 0.3 0.8])
% yline(max_LG_TF(500),'--',spec2,'LineWidth',3,'Color',[0.5 0.3 0.8])

% absolute max
xline(maxTF,'--','LineWidth',3,'Color',[1 0 0])
yline(abs_maxLG,'--',spec4,'LineWidth',3,'Color',[1 0 0]);
set(gca,"FontSize",13)

end

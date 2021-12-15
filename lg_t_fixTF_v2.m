function [LG_all] = lg_t_fixTF_v2(TF,time,p)
% explore how LG changes over time for a fixed TF


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
TF_span = [0:0.01:TF*1.5]; 
length(TF_span)
tspan = [0:0.01:time];
TR_all = zeros(length(tspan),length(TF_span)); % store time dependent TR for each unique TF

ind = find(TF_span == TF) % find where the TF of itnerest is (which column)

figure();
% simulate model
for jj = 1:length(TF_span)
    [t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF_span(jj)),tspan,y0);
    TR_all(:,jj) = transcription_rate_ss(y_pred(:,1),1); % assume prod_rate = 1
    xlabel("time")
    ylabel("transcription rate")
    title("TR vs. time for different TF")
    set(gca,"FontSize",13)
    plot(tspan,TR_all(:,jj));
    hold on
    if jj == ind
        plot(tspan,TR_all(:,jj),'d');
    end
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


% make sure to comment this out when running main to decrease run time
figure();
plot(tspan,LG_all(:,ind),"LineWidth",4)
xlabel("time")
ylabel("log gain in TR/TF")
spec = sprintf("transient response of log gain at TF = %0.5f",TF);
title(spec)
set(gca,"FontSize",13)



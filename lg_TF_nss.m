function abs_maxLG = lg_TF_nss(p,time)

time = 100;
p = [0.9,0.78,0.54,0.3,0.03,0.02,0.01,0.07,0.1];
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
y0 = [0,0,0,1]'; % start with unoccupied, inactive
    
% try all possible TF concentration and simulate for designated seconds
TF_span = [0.1:0.1:15]; 
tspan = [0.1:0.1:time];
TR_all = []; % store time dependent TR for each unique TF

% [t, y_pred] = ode23s(@(t,y)Pa_nss4_t(t,y,pars,3),tspan,y0);

% simulate model
for jj = 1:length(TF_span)
    [t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF_span(jj)),tspan,y0);
    TR_all = [TR_all,prod_rate.*y_pred(:,1)];
end

% calculate log gain for each time point at each TF
LG_all_t = zeros(1,150);
for gg = 1:length(tspan)
    log_gain = gradient(log(TR_all(gg,:))) ./ gradient(log(TF_span));
    LG_all_t = cat(1,LG_all_t,log_gain);
end

% find the max log gain among all TF, all time
abs_maxLG = max(LG_all_t(:));

% plot what is the max LG for each time point
max_LG_t = [];
for tt = 1:length(tspan)
    max_LG_t = [max_LG_t,max(LG_all_t(tt,:))];
end
% 
figure();
plot(tspan,max_LG_t,"LineWidth",4)
xlabel("time")
ylabel("maximum log gain in TR/TF")
title("maximum log gain of TR/TF, time dependent")
set(gca,"FontSize",13)

    
    
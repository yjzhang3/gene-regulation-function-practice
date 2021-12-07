function [maxLG,log_gain] = lg_t_fixTF(TF,time,p)
% explore how LG changes over time for a fixed TF

h = 0.005; % numerical diffentiation parameter

% % sample parameters
% p = [0.9,0.78,0.54,0.3,0.03,0.02,0.01,0.07,0.1];
% time = 10;
% TF = 2;


% set up model parameters (these will be fed into ODE solver)
pars.Kab= p(1);
pars.Kba = p(2);
pars.Kbd = p(3);
pars.Kdb0 = p(4);
pars.Kcd = p(5);
pars.Kdc = p(6);
pars.Kca0 = p(7);
% pars.Kac = p(8);
% impose equilibrium condition
pars.Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2));
prod_rate = p(8);

% time to be explored
tspan = [0:0.01:time];

% initial condition
y0 = [0,0,0,1]; % start with unoccupied, inactive

% simulate model for f(x), f(x+h) and f(x-h)
[t, y_pred] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF),tspan,y0);
[t, y_predl] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF-h),tspan,y0);
[t, y_predr] = ode23s(@(t,y)Pa_nss4(t,y,pars,TF+h),tspan,y0);

% extract the probability of state A (active, occupied)
y_pred = y_pred(:,1);
y_predl = y_predl(:,1); % point immediately to the left
y_predr = y_predr(:,1); % ... right

% store the transcription rate after interpolation
TR = zeros(length(tspan),1); 
TR_l = zeros(length(tspan),1);
TR_r = zeros(length(tspan),1);
% interpolate to make sure time step for all 3 trajectories are the same
for i = 1:length(tspan)
    vq = interp1(tspan,y_pred,tspan(i));
    TR(i) = vq;
    vql = interp1(tspan,y_predl,tspan(i));
    TR_l(i) = vql;
    vqr = interp1(tspan,y_predr,tspan(i));
    TR_r(i) = vqr;
end

% calculate log gain at each time point
% since there is no TF span here in this function, try to use the 
% two-point central difference formula f(x+h)-f(x-h)/2h to approximate log
% gain at each time point
log_gain = zeros(length(tspan),1);
for j = 1:length(tspan)
    dTRdTF = (TR_r(j)-TR_l(j))/(2*h);
    lg = TF/TR(j)*dTRdTF;
    log_gain(j) = lg;
end

maxLG = max(log_gain);
spec = sprintf('transient state log gain vs. time with TF = %0.5f simulated over %0.5f seconds',TF,time);
plot(tspan,log_gain,"LineWidth",4)
title(spec)
xlabel('time')
ylabel('log gain')
spec1 = sprintf('non-steady state max LG @ TF = %0.5f is %0.5f',TF,maxLG);
yline(maxLG,'--',spec1,'LineWidth',3,'Color',[0.1 0.9 0.2])
set(gca,"FontSize",13)
hold on


end
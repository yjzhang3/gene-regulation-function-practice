function [maxLG,maxT] = lg_TF_nss_v2(p,t,TF)
% input: parameters and simulation time, and a *particular* TF value
% output: the log gain in TR w.r.t this TF over time

tspan = [0:0.1:t];

pars.Kab= p(1);
pars.Kba = p(2);
% pars.Kac = p(2);
pars.Kbd = p(3);
pars.Kdb0 = p(4);
pars.Kcd = p(5);
pars.Kdc = p(6);
pars.Kca0 = p(7);
% pars.Kac = p(8); % neq 
pars.Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2)); % eq
% pars.Kba = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2));

%% check if Kac is too big for eq
if pars.Kac > 7000
    maxLG = 0.01;
    maxT = -1;
    % pars
    return
end

%%
% y0 = [0;0;0;1;0;0;0;0];
y0 = [0;0;0;0;0;0;0;0];
[y0(1),y0(2),y0(3),y0(4)] = ss_ic(pars.Kcd,pars.Kdc);
[t,ypred] = ode23s(@(t,y) local_sens(t,y,pars,TF),tspan,y0);

% LG = TF/TR*dTR/dTF, and the transcription rate is proportional to the
% probaility of staying in state A, and derivative of state A wrt TF
LG = TF./ypred(:,1).*ypred(:,5);

[maxLG,i] = max(LG);
maxT = tspan(i);

%% remember to comment this plotting part during optimization
% figure();
% plot(tspan,LG)
% % plot(tspan,LG,'LineWidth',4,'DisplayName',sprintf('TF = %0.2f',TF))
% xlabel('time')
% ylabel('log gain in TR wrt TF')
% spec = sprintf('transient log gain at TF = %0.5f',TF);
% set(gca,"FontSize",15)
% title(spec)
% spec1 = sprintf('quasi steady state LG = %0.5f', LG(end));
% yline(LG(end),'-',spec1)
end




function [maxLG,maxT] = lg_TF_nss_v2(p,t,TF)
% input: parameters and simulation time, and a particular TF value
% output: the log gain in TR w.r.t this TF over time

tspan = [0:0.1:t];

pars.Kab= p(1);
pars.Kba = p(2);
pars.Kbd = p(3);
pars.Kdb0 = p(4);
pars.Kcd = p(5);
pars.Kdc = p(6);
pars.Kca0 = p(7);
pars.Kac = p(8); % neq
% pars.Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2)); % eq

y0 = [0;0;0;1;0;0;0;0];
[t,ypred] = ode23s(@(t,y) local_sens(t,y,pars,TF),tspan,y0);

% LG = TF/TR*dTR/dTF, and the transcription rate is proportional to the
% probaility of staying in state A, and derivative of state A wrt TF
LG = TF./ypred(:,1).*ypred(:,5);

[maxLG,i] = max(LG);
maxT = tspan(i);
plot(tspan,LG)
xlabel('time')
ylabel('log gain in TR wrt TF')
spec = sprintf('transient log gain at TF = %0.5f',TF);
title(spec)
end




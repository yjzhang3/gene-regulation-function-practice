function dydt = Pa_ss4_num(y,pars,TF)
% numerical diffentiation for steady state

Kca = pars.Kca0*TF;
Kdb = pars.Kdb0*TF;

Pa=y(1);
Pb=y(2);
Pc=y(3);
Pd=y(4);

dydt(1) = -Pa*pars.Kab - Pa*pars.Kac + Pb*pars.Kba + Pc*Kca;
dydt(2) = -Pb*pars.Kbd - Pb*pars.Kba + Pd*Kdb + Pa*pars.Kab;
dydt(3) = -Pc*pars.Kcd - Pc*Kca + Pd*pars.Kdc + Pa*pars.Kac;
dydt(4) = -Pd*Kdb - Pd*pars.Kdc + Pb*pars.Kbd + Pc*pars.Kcd; 


end 

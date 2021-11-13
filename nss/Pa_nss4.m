function dydt = Pa_nss4(t,y,pars,TF)

Kca = pars.Kca0*TF;
Kdb = pars.Kdb0*TF;

Pa=y(1);
Pb=y(2);
Pc=y(3);
Pd=y(4);

dPadt = -Pa*pars.Kab - Pa*pars.Kac + Pb*pars.Kba + Pc*Kca;
dPbdt = -Pb*pars.Kbd - Pb*pars.Kba + Pd*Kdb + Pa*pars.Kab;
dPcdt = -Pc*pars.Kcd - Pc*Kca + Pd*pars.Kdc + Pa*pars.Kac;
dPddt = -Pd*Kdb - Pd*pars.Kdc + Pb*pars.Kbd + Pc*pars.Kcd; 
dydt = [dPadt; dPbdt; dPcdt; dPddt];

end 

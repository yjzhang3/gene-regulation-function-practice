function dydt = local_sens(t,y,pars,TF)

Kca = pars.Kca0*TF;
Kdb = pars.Kdb0*TF;

Pa=y(1);
Pb=y(2);
Pc=y(3);
Pd=y(4);
dPadTF = y(5);
dPbdTF = y(6);
dPcdTF = y(7);
dPddTF = y(8);

% system of equations for the biochemical reactions
dPadt = -Pa*pars.Kab - Pa*pars.Kac + Pb*pars.Kba + Pc*Kca;
dPbdt = -Pb*pars.Kbd - Pb*pars.Kba + Pd*Kdb + Pa*pars.Kab;
dPcdt = -Pc*pars.Kcd - Pc*Kca + Pd*pars.Kdc + Pa*pars.Kac;
dPddt = -Pd*Kdb - Pd*pars.Kdc + Pb*pars.Kbd + Pc*pars.Kcd; 

% derived another 4 equations, which is the time derivative of dP/dTF
ddtdPadTF = -(pars.Kab+pars.Kac)*dPadTF + pars.Kba*dPbdTF + Kca*dPcdTF + pars.Kca0*Pc;
ddtdPbdTF = pars.Kab*dPadTF - (pars.Kba+pars.Kbd)*dPbdTF + Kdb*dPddTF + pars.Kdb0*Pd;
ddtdPcdTF = pars.Kac*dPadTF - (Kca+pars.Kcd)*dPcdTF + pars.Kdc*dPddTF - pars.Kca0*Pc;
ddtdPddTF = pars.Kbd*dPbdTF + pars.Kcd*dPcdTF - (pars.Kdc+Kdb)*dPddTF - pars.Kdb0*Pd;

% solve 8 equations simultaneously
dydt = [dPadt; dPbdt; dPcdt; dPddt; ddtdPadTF; ddtdPbdTF; ddtdPcdTF; ddtdPddTF];

end 

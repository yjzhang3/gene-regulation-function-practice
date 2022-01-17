function lg = local_sens_ss_v2(k,TF)
% if coefficient and production rate are known, what is the log gain at
% specific TF for steady state

% prod_rate = 0.3;
% p = [0.1,0.2,0.2,0.3,0.1,0.2,0.9,0.7,0.1]; example parameters in case you
% need them

lg = TF/Pa_ss4(k,TF)*dPadTF(k,TF);
% x/y*dydx = local sensitivity

end


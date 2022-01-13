function lg = lg_ss(k,prod_rate)
% if coefficient and production rate are known, what is the log gain at
% specific TF for steady state

% prod_rate = 0.3;
% p = [0.1,0.2,0.2,0.3,0.1,0.2,0.9,0.7,0.1]; example parameters in case you
% need them
syms x

f = @(x) transcription_rate_ss(Pa_ss4(k,x),prod_rate); % TR
f1 = eval(['@(x)' char(diff(f(x)))]); % dTR/dTF

lg = @(x) x/f(x)*f1(x); % LG = TF/TR*dTR/dTF
end
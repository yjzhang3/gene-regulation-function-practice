% function lg = lg_ss_unkn_k(prod_rate)
% if coefficient are NOT known, what is maximum log gain
prod_rate = 0.3;

syms Kab Kba Kbd Kdb0 Kcd Kdc Kca0 Kac x
syms f(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x)
f(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x) = prod_rate*Pa_ss4_1(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x); % TR
f1 = eval(['@(x)' char(diff(f,x))]); % dTR/dTF

syms lg(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x)
lg(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x) = -1*x/f(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x)*f1(x); % LG = TF/TR*dTR/dTF
% note the -1 here. It is used to find maximum log gain (min of neg log ==
% max of pos log)

% convert symbolic math into function handle
ht = matlabFunction(lg); 

% find ks that maximize negative log
% k0 = [0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 1];
% k = fminsearch(ht,k0);

%%
[fit, score] = fmincon(@(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x) ht(Kab,Kba,Kbd,Kdb0,Kcd,Kdc,Kca0,Kac,x),[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 1], [],[],[],[],[1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 1E-5 0.1],[2,2,2,2,2,2,2,2,10]);
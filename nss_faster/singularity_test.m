function [rcond_old,A_new,rcond_final] = singularity_test(p,c)

Kab= p(1);
Kba = p(2);
Kbd = p(3);
Kdb0 = p(4);
Kcd = p(5);
Kdc = p(6);
Kca0 = p(7);
% Kac = p(8); % neq
% TF = p(9);

Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2)); % eq
TF = p(8);

A = [[-Kab-Kac,Kba,Kca0*TF,0,0,0,0,0];
    [Kab,-Kba-Kbd,0,Kdb0*TF,0,0,0,0];
    [Kac,0,-(Kca0*TF+Kcd),Kdc,0,0,0,0];
    [0,Kbd,Kcd,-(Kdc+Kdb0*TF),0,0,0,0];
    [0,0,Kca0,0,-(Kab+Kac),Kba,Kca0*TF,0];
    [0,0,0,Kdb0,Kab,-(Kba+Kbd),0,Kdb0*TF];
    [0,0,-Kca0,0,Kac,0,-(Kca0*TF+Kcd),Kdc];
    [0,0,0,-Kdb0,0,Kbd,Kcd,-(Kdc+Kdb0*TF)]];

rcond_old = rcond(A);
% D = [-Kab-Kac,-Kba-Kbd,-(Kca0*TF+Kcd),-(Kdc+Kdb0*TF),-(Kab+Kac),-(Kba+Kbd),-(Kca0*TF+Kcd),-(Kdc+Kdb0*TF)];


%% adjust the ill-conditioned matrix
% if A is well condtioned, rcond near 1.0.

A_new = A + c*eye(size(A));
rcond_test = rcond(A_new);

c_test = [1:1000];
for cc = 1:length(c_test)
    A_new = A + c_test(cc)*eye(size(A));
    rcond_new = rcond(A_new);
    if rcond_new > rcond_test
        rcond_test = rcond_new;
        c_best = c_test(cc);
    end
end

%%
A_new = A + c_best*eye(size(A));
rcond_final = rcond(A_new);

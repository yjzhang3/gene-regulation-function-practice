Kab = 1000;
Kba = 999.65;
Kbd = 79.7394;
Kdb0 = 0.0100;
Kcd = 7.8289;
Kdc = 0.0100;
Kca0 = 1000;
% Kac = 1.0189e+4;
Kac = Kab*Kbd*Kdc*Kca0*TF/(Kba*Kcd*Kdb0*TF);
TF = 1;

mat = [[-Kab-Kac,Kba,Kca0*TF,0,0,0,0,0];
    [Kab,-Kba-Kbd,0,Kdb0*TF,0,0,0,0];
    [Kac,0,-(Kca0*TF+Kcd),Kdc,0,0,0,0];
    [0,Kbd,Kcd,-(Kdc+Kdb0*TF),0,0,0,0];
    [0,0,Kca0,0,-(Kab+Kac),Kba,Kca0*TF,0];
    [0,0,0,Kdb0,Kab,-(Kba+Kbd),0,Kdb0*TF];
    [0,0,-Kca0,0,Kac,0,-(Kca0*TF+Kcd),Kdc];
    [0,0,0,-Kdb0,0,Kbd,Kcd,-(Kdc+Kdb0*TF)]];

det_mat = det(mat);
rcond_mat = rcond(mat);
cond_mat = cond(mat);

function max = lhsmax_nss(n,TF,t)

%% latin hypercube sampling
% TF = 5;
maxLG = 0;
for tt = 1:n
    p = lhsdesign(1,9);
    lg = lg_TF_nss(p,t,TF);
    if lg > maxLG
        maxLG = lg;
    end
end
max = maxLG;
end

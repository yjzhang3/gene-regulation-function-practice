% find k and production rate that maximizes log gain for steady state

%% latin hypercube sampling
TF = 10;
maxLG_lhs = 0;
for tt = 1:100
    p = lhsdesign(1,9);
    lg = lg_TF_ss(p,TF);
    if lg > maxLG_lhs
        maxLG_lhs = lg;
    end
end
maxLG_lhs
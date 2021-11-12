function max = lhsmax_ss(n,TF)

%% latin hypercube sampling
% TF = 5;
ss_maxLG_lhs = 0;
for tt = 1:n
    p = lhsdesign(1,9);
    lg = lg_TF_ss(p,TF);
    if lg > ss_maxLG_lhs
        ss_maxLG_lhs = lg;
    end
end
max = ss_maxLG_lhs;
end
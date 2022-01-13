%% test if the TF that maximizes the log gain is always the largest log gain
% p1 = rand([8 1])';
p2 = rand([8 1]).^0.45+abs(log(p1)).*100';

[maxLG1,maxTF1,log_gain1] = lg_TF_ss(p2(1,:),100);
% [maxLG2,maxTF2,log_gain2] = lg_TF_ss(p2,20);
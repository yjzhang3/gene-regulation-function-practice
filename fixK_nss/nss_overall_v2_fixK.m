%% find best log gain and parameters for non-steady state given particular TF
% remember to comment out figure section
% using k found before in brute force methods
% p = [[1000,842,63,1000,0.01,36,0.01,1000];[445,13,252,1000,0.01,262,0.01,775];[805,788,653,0.01,0.01,0.01,984,713]];

% use the best parameters k found by another pipeline that fixed TF
tic
p = reshape(p_new,[length(p_new),7]);
T_test = 5;
[maxLG_arr,maxTF_arr,maxT_arr] = main_nss_v2_fixK(p,T_test);
toc
%% plot and verify max LG using best Ks
% now cancel the comments
for ii = 1:length(p(:,1))
    lg_TF_nss_v4_fixK(p(ii,:),T_test,maxTF_arr(ii));
    hold on
    % legend(sprintf("TF = %0.5f",maxTF_arr(ii)));
end

%% compare prepared TF and maxTF
TF_test = [20:0.1:50];
plot(TF_test,'.','DisplayName','provided TF');
hold on
plot(maxTF_arr,'^','DisplayName','optimized TF')
legend('provided TF','optimized TF')
xlabel('index')
ylabel('TF concentration')
set(gca,"FontSize",15)

function [maxLG,maxTF,log_gain] = lg_TF_ss(p,TF)
% find the maximum log gain

TF_span = [0:0.01:TF]; % try all possible TF concentration
tr_all = zeros(1,length(TF_span));
% k = p(1:8);
k = p(1:7);
 
% transcription rate at each TF
for ii = 1:length(TF_span)
    Pa = Pa_ss4(k,TF_span(ii));
%     tr = transcription_rate_ss(Pa,p(9));
    tr = transcription_rate_ss(Pa,p(8));
    tr_all(ii) = tr;
end

% log gain at each TF
% log_gain = diff(log(tr_all))./diff(log(TF_span));
log_gain = gradient(log(tr_all)) ./ gradient(log(TF_span));

[maxLG,I] = max(log_gain);
maxTF = TF_span(I);


%% graph showing the relationship between TF and TR
% comment this section out when runnign mean
% figure();
% plot(TF_span,tr_all,'LineWidth',4);
% xlabel("TF")
% ylabel("TR")
% title("Transcription rate vs. [transcription factor]")
% set(gca,"FontSize",13)
% 
% figure();
% loglog(TF_span,tr_all,'s','MarkerFaceColor',[0 0.447 0.741]);
% grid on;
% xlabel("log(TF)")
% ylabel("log(TR)")
% title("log(Transcription) rate vs. log([transcription factor])")
% set(gca,"FontSize",13)
% 
% 
figure();
spec = sprintf('log gain vs. [transcription factor] for TF range [0,%0.5f]',TF);
plot(TF_span,log_gain,'s','MarkerFaceColor',[0 0.447 0.741])
xlabel("TF")
ylabel("log gain")
title(spec)
set(gca,"FontSize",13)
end



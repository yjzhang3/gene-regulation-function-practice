function [maxLG,maxTF,log_gain] = lg_TF_ss(p,TF)
% find the maximum log gain

TF_span = [0:0.01:TF]; % try all possible TF concentration
tr_all = zeros(1,length(TF_span));

%% exact solution
% assume production rate to be 1 for now
k = p(1:8); % neq
% k = p(1:7); % eq
 
% transcription rate at each TF
for ii = 1:length(TF_span)
    Pa = Pa_ss4(k,TF_span(ii));
    tr = transcription_rate_ss(Pa,1); % non-equilibrium
    tr_all(ii) = tr;
end

%% numerical solution
% pars.Kab= p(1);
% pars.Kba = p(2);
% pars.Kbd = p(3);
% pars.Kdb0 = p(4);
% pars.Kcd = p(5);
% pars.Kdc = p(6);
% pars.Kca0 = p(7);
% % pars.Kac = p(8);
% % impose equilibrium condition
% pars.Kac = p(1)*p(3)*p(6)*p(7)/(p(5)*p(4)*p(2));
% 
% x0 = [0,0,0,1];
% % transcription rate at each TF using numerical 
% for ii = 1:length(TF_span)
%     % use fsolve??
%     % solut = fsolve(@(y)Pa_ss4_num(y,pars,TF_span(ii)),x0,options)
%     
%     % use fmincon??
%     fun2 = @(y) sum(Pa_ss4_num(y,pars,TF_span(ii)).^2);
%     one_solution = fmincon(fun2, x0, [], [], [], [], zeros(1,8), zeros(1,8)+1);
%     Pa = one_solution(1);
% %     tr = transcription_rate_ss(Pa,p(9));
%     tr = transcription_rate_ss(Pa,p(8));
%     tr_all(ii) = tr;
% end


%% log gain at each TF
% log_gain = diff(log(tr_all))./diff(log(TF_span));
log_gain = gradient(log(tr_all)) ./ gradient(log(TF_span));

[maxLG,I] = max(log_gain);
maxTF = TF_span(I);


%% graph showing the relationship between TF and TR
%comment this section out when runnign mean
figure();
plot(TF_span,tr_all,'s','MarkerFaceColor',[0 0.447 0.741]);
xlabel("TF")
ylabel("TR")
title("Transcription rate vs. [transcription factor]")
set(gca,"FontSize",13)

figure();
loglog(TF_span,tr_all,'s','MarkerFaceColor',[0 0.447 0.741]);
grid on;
xlabel("log(TF)")
ylabel("log(TR)")
title("log(Transcription) rate vs. log([transcription factor])")
set(gca,"FontSize",13)


figure();
spec = sprintf('log gain vs. [transcription factor] for TF range [0,%0.5f]',TF);
plot(TF_span,log_gain,'s','MarkerFaceColor',[0 0.447 0.741])
xlabel("TF")
ylabel("log gain")
title(spec)
set(gca,"FontSize",13)
end



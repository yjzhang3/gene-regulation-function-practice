function lg = fit_model_nss(p,time,TF)

absMaxLG = lg_TF_nss(p,time,TF);
lg = absMaxLG*-1;

end


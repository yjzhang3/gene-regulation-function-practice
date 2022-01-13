function lg = local_sens_ss(k,TF)
% input: specific TF, reaction rate k
% output: local sensitivity at this TF

fun_LG = lg_ss(k,1); 
% a generic function that can calculate log gain at a specific TF
% assume reaction rate is 1

lg = fun_LG(TF); 
end

function [Pa,Pb,Pc,Pd] = ss_ic(kcd,kdc)
% calculate the initial condition that makes more biological sense, which
% is also what makes system at steady state at t = 0
Pa = 0;
Pb = 0;
Pc = kdc/(kcd + kdc);
Pd = kcd/(kcd + kdc);

end 
function [regression, param] = calc_reg(data, rate, I, type)
% tries to fit a gaussian curve (type=0) or a exp function (type=1) to the envelope

stoI = 0.0001;
niter = 60;
x = 1:length(data);
ack = 0; 

global verbose;
verbose = 0;

if type == 0
  init = [data(I); I; length(data)/3; 0];
  name = 'gaussEqn';
else
  init = [1/length(data)];
  name = 'expEqn';
end

[f, p, cvg, iter, corp, covp] = leasqr(x', data', init, name, stoI, niter);

if type == 0
  param = abs(p(3))/sqrt(2);
else
  param = p(1);
end

if cvg == 0
  param = NaN;
end

regression = f';
end
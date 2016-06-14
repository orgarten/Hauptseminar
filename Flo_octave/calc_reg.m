function [regression, sigma] = calc_reg(envelope, rate, I)
% tries to fit a gaussian curve to the envelope

stoI = 0.0001;
niter = 40;
x = 1:length(envelope);
data = zeros(1, length(envelope));

for i = I:-1:1
  if envelope(i) < envelope(I)/20
    data_min = i;
    break
  end
end
for i = I:1:length(envelope)
  if envelope(i) < envelope(I)/20
    data_max = i;
    break
  end
end

data(data_min:1:data_max) = 1;
 
init = [envelope(I); I; length(envelope)/3];

data = data .* envelope;

global verbose;
verbose = 0;

[f, p, cvg, iter, corp, covp] = leasqr(x', data', init, 'gaussEqn', stoI, niter);

sigma = p(3)/sqrt(2);
regression = f';
end
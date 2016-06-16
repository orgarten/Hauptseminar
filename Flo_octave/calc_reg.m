function [regression, sigma, ampl] = calc_reg(envelope, rate, I)
% tries to fit a gaussian curve to the envelope

stoI = 0.0001;
niter = 60;
x = 1:length(envelope);
data = zeros(1, length(envelope));
ack = 0; 

init = [envelope(I); I; length(envelope)/3; 0];

global verbose;
verbose = 0;

[f, p, cvg, iter, corp, covp] = leasqr(x', envelope', init, 'gaussEqn', stoI, niter);

sigma = abs(p(3))/sqrt(2);
ampl = p(1)*(length(envelope)/rate)^2/max(envelope);
regression = f';
end
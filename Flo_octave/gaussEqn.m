function [y] = gaussEqn(x, par)
y = par(1)*exp(-(x-par(2)).^2/(2*par(3).^2))+par(4);
end
function [y] = expEqn(x, par)
y = exp(-x*par(1))+par(2);
end
function [ A ] = buildXLSMatrix(A, audiofile, duration, rate, ripple, sigma, ex, area, t_diff)
%BUILDXLSMATRIX builds the correct matrix to save
  A = [A; {audiofile duration rate ripple sigma ex area t_diff}];
end;
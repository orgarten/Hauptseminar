function [ A ] = buildXLSMatrix(A, audiofile, duration, ripple, sigma, ex, t_diff)
%BUILDXLSMATRIX builds the correct matrix to save
  A = [A; {audiofile duration ripple sigma ex t_diff}];
end;
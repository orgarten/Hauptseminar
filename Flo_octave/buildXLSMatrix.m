function [ A ] = buildXLSMatrix(A, audiofile, ripple, sigma, dc, t_diff)
%BUILDXLSMATRIX builds the correct matrix to save
  A = [A; {audiofile ripple sigma dc t_diff}]
end;
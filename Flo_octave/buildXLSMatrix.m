function [ A ] = buildXLSMatrix(A, audiofile, ripple, sigma)
%BUILDXLSMATRIX builds the correct matrix to save
  A = [A; {audiofile ripple sigma}]
end;
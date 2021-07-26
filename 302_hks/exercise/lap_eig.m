function [evals, evecs] = lap_eig(V, F, k)
  % Compute the eigendecomposition of the laplacian
  %
  % Inputs:
  %   V  matrix, size (V,3), of mesh vertex positions
  %   F  matrix, size (F,3), of element indices into V
  %   k  number of eigenvalues and eigenfunctions to compute
  % Outputs:
  %   evals  vector, length k, of eigenvalues
  %   evecs  matrix, size (V,k), list of eigenfunctions
  
  W = -cotmatrix(V,F); % laplacian, the minus aign is for convention
  A = massmatrix(V,F);

  [evecs, D] = eigs(W, A, k, -1e-5);  
  evals = diag(D);
  
% Compute the k smallest eigenvalues and eigenfunctions of the laplacian.
% Return them in a sorted order - from the smallest eigenvalue to the
% largest.
% Use: [evecs, evals] = eigs(W, A, k, -1e-5);
% instead of: [evecs, evals] = eigs(W, A, k, 'sm');
% for better results.

end

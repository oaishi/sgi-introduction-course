function GPS = globalPointSignature(V, F, k)
  % Compute the global Point Signature
  % "Laplace-Beltrami eigenfunctions for deformation invariant shape
  % representation", Rustamov, 2007
  %
  % Inputs:
  %   V  matrix, size (V,3), of mesh vertex positions
  %   F  matrix, size (F,3), of element indices into V
  %   k  number of eigenvalues and eigenfunctions to use
  % Outputs:
  %   GPS  matrix, size (V,k), of GPS
  
  [evals, phi] = lap_eig(V, F, k);
  GPS = zeros(size(V,1), size(evals,1) - 1);
  [r_, c_] = size(evals);
  
  for i = 2 : r_
    % (i - 1) because we are dismissing the first eigen function, which is constant    
    GPS(:, i - 1) = phi(:, i) / (evals(i))^(1/2);      
  end
  
end
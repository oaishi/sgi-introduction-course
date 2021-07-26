function [HKS, t] = heatKernelSignature(V, F)
  % Compute the heat kernel signature
  % "A Concise and Provably Informative Multi-Scale SignatureBased on 
  % Heat Diffusion", Sun et al., 2009
  %
  % Inputs:
  %   V  matrix, size (V,3), of mesh vertex positions
  %   F  matrix, size (F,3), of element indices into V
  %   k  number of eigenvalues and eigenfunctions to use
  % Outputs:
  %   HKS  matrix, size (V,k), of HKS
  
    ki = 300; % amount of eigenvalues and functions to use, you can add more
    
    % Compute the first k eigenvalues and eigenfunctions of the laplacain
    % Don't forget to sort them....
    [evals, phi] = lap_eig(V, F, ki);

    % We uniformly sample 100 points in the logarithmically scale over the following time
    % interval, as suggested in the paper:
    nt = 100;
    tmin = 4*log(10)/evals(end); % evals is a vector of ki eigenvalues of the laplacian
    tmax = 4*log(10)/evals(2);
    t = logspace(log10(tmin),log10(tmax),nt); 
    kt_scaled = zeros(nt, 1);
    
    % Compute the HKS descriptor
    HKS = zeros(size(V,1), nt); % HKS  matrix, size (V,k), of HKS
    
    phi_square = phi .* phi; % we need the element wise squared value
    
    for t_iter = 1 : nt  
        for eig_iter = 1 : ki            
            HKS(:, t_iter) = HKS(:, t_iter) + exp(evals(eig_iter) * -1 * t(t_iter)) * phi_square(:, eig_iter);   
            kt_scaled(t_iter, :) = kt_scaled(t_iter, :) + exp(evals(eig_iter) * -1 * t(t_iter));
        end
    end 

    % task 2
    % disp(size(HKS));
    % disp(size(kt_scaled));
    HKS = HKS ./ kt_scaled';
end

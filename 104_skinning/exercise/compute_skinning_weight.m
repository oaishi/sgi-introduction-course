function W = compute_skinning_weight(V,F,b)
%%%%%%%%%%
% TASK: implement (unbounded) biharmonic weights, which solves the
% following optimization problem: 
%      min   0.5 * trace( W'*Q*W )
%      s.t.  W(b,:) = bc
%
% black list:
% - min_quad_with_fixed
%
% white list (hints)
% - "cotmatrix" for computing cotangent Laplacian
% - "massmatrix" for computing mass matrix
%
% Hint:
% - give a diagonal matrix A, you can invert A with 
%   >> invA = diag(diag(A).^(-1));
% - constraints are 1 for a handle and 0 for other handls, so it is like
%   >> bc = eye(length(b));
% - you shouldn't need any other functions in gptoolbox
%%%%%%%%%%

% naive closest point (replace this one with your solution)
% idx = knnsearch(V(b,:),V);
% W = full(sparse([1:size(V,1)], idx, 1, size(V,1), length(b)));

L = cotmatrix(V,F);
M = massmatrix(V,F);
B = L * diag(diag(M).^(-1)) * L;
bc = eye(length(b));
    
unknown = [1: size(V,1)]';
unknown(b) = [];
LHS = B(unknown, unknown);

W = zeros(size(V, 1), length(b));

for ii = 1:length(b)
        
    RHS = B(unknown, b) * bc(:, ii);
    W_unknown = - LHS \ RHS;
    
    W(unknown, ii) = W_unknown;
    W(b, :) = bc;

    
end
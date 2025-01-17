function [U] = linear_blend_skinning(V, T, W)
%%%%%%%%%%
% TASK: implement linear blend skinning
%
% optional CHALLENGE: implement a faster linear blend skinning without 
% "for" loops
%
% Hint:
% - you shouldn't need any other functions in gptoolbox
%
% Note:
% It is a convention that we typycally assume a vertex location is stored
% as a dim-by-1 column vector like v = [vx; vy]". But when we assemble all 
% vertices as a matrix V = [v1, v2, ...], we typycally do not store it as
% a (natural) dim-by-#V matrix. We instead store the transpose of it as a
% #V-by-dim matrix V = [v1'; v2'; ...] (probably) because of the default 
% column-major storage format. Therefore, in this implementation V and U
% are both #V-by-dim matrices. If you want to extract the location of
% vertex i, then you can do something like vi = V(i,:)'. This convention
% may be confusing at first glance when you compare it with the write-up
% but don't worry, when you pay attention to matrix dimensions, we can work
% through it together!
%%%%%%%%%%

% naive closest point (replace this one with your solution)


Homolog_v = ones(3,  size(V,1));
new_V = V';
Homolog_v(1,:) = new_V(1,:);
Homolog_v(2,:) = new_V(2,:);

U = zeros(2, size(V,1));

[r, c] = size(W);

for i= 1: c
    disp(size(W(:,i)));
    disp("printing W");
    disp(size(T(:, :, i)));
    disp("printing T");
    disp(size(Homolog_v));
    disp("printing V");

    U = U + (W(:,i) .* (T(:, :, i)  * Homolog_v)')';
end

U = U';

end
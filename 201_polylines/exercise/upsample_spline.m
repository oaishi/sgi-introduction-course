function U = upsample_spline(V,n)
% Sample n equally spaced points on the Catmull-Rom spline defined by V
% [r_, c_] = size(P);

U = zeros(n, 2);
t = linspace(0,1,n);

% for i = 1:n    
  %   disp(t);
    % U(i,:) = catmull_rom_interpolation(V,t);
% end

for i = 1:length(t)
    U(i,:) = catmull_rom_interpolation(V, t(i));
end
  
end
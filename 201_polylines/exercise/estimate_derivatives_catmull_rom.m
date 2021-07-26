function M = estimate_derivatives_catmull_rom(P)
% Assuming P are the points of a closed curve, use the Catmull-Rom
% technique to estimate the derivative at each point of P by looking at its
% neighbors

[r_, c_] = size(P);
M = zeros(size(P));

for i = 1:r_    
    if i == 1
        M(i,:) = 0.5 * (P(i+1,:) - P(r_,:));
    elseif i == r_
        M(i,:) = 0.5 * (P(1,:) - P(i-1,:));
    else
        M(i,:) = 0.5 * (P(i+1,:) - P(i-1,:));
    end    
end

end
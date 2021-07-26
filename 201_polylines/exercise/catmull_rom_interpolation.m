function Pt = catmull_rom_interpolation(P,t)
% P is a set of points, which we assume are corresponded to equally spaced
% times between 0 and 1. t is a scalar value between 0 and 1. Return the
% value of the catmull-rom interpolation of P at time t. You may use
% cubic_hermite.m, 

M = estimate_derivatives_catmull_rom(P); 
[r_, c_] = size(P);

% append the first values to the last of the array to get closed loop
% otherwise I wouldget an open curve
% make sure to do this after calculating tangent, otherwise the tangent
% would be in different directions and the result will not be smooth
P(r_ + 1, :) = P(1, :);
M(r_ + 1, :) = M(1, :);

[r_, c_] = size(P);
control_points = linspace(0, 1, r_);

% disp(control_points);

% getting the interpolated value to reach the correct 'piece'
for i = 1:(r_ - 1)    
    if (t >= control_points(i) && t <= control_points(i + 1))
        next = i + 1;
        next_ = control_points(i + 1);
        prev_ = control_points(i);
        % disp("found");
       break 
    end
end

% mapping the t to current 'piece'
t_ = (t - prev_) / (next_ - prev_);
Pt = cubic_hermite(P(next - 1, :), P(next, :), M(next - 1, :), M(next, :), t_);
end
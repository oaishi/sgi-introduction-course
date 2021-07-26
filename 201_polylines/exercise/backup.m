function Pt = backup(P,t)
% P is a set of points, which we assume are corresponded to equally spaced
% times between 0 and 1. t is a scalar value between 0 and 1. Return the
% value of the catmull-rom interpolation of P at time t. You may use
% cubic_hermite.m, 

[r_, c_] = size(P);
% getting the interpolated value to reach the correct 'piece'
next = ceil(1 + (t * (r_ - 1))); 

if next == 1
    prev = r_;
else
    prev = next - 1;
end

disp(prev);
disp(next);

% mapping the t to current 'piece'
next_ = (next - 1) / (r_ - 1);
prev_ = (prev - 1) / (r_ - 1);
t_ = (t - prev_) / (next_ - prev_);

disp(prev_);
disp(next_);
disp(t_);

M = estimate_derivatives_catmull_rom(P); 
Pt = cubic_hermite(P(prev, :), P(next, :), M(prev, :), M(next, :), t_);
if t == 0
    next = 2;
    next_ = control_points(2);
    prev_ = 0;
elseif t == 1
    next = r_;
    next_ = control_points(r_);
    prev_ = control_points(r_ - 1);
else
    % disp("working for " + t);
    for i = 1:(r_ - 1)    
        if (t >= control_points(i) && t <= control_points(i + 1))
            next = i + 1;
            next_ = control_points(i + 1);
            prev_ = control_points(i);
            % disp("found");
           break 
        else
            % disp("not_found");
        end
    end
end    

end
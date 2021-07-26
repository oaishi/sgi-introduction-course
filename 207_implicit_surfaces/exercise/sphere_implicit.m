function I = sphere_implicit(center,radius,P)
    % Calculate the value of an implicit function representing a sphere of a
    % given radius and center at a given *set* of points P
    I = (P(:,1) - center(:,1)).^2 + (P(:,2)- center(:,2)).^2 + (P(:,3) - center(:,3)).^2 - radius^2;

end
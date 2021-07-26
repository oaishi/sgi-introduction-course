function N = my_normals(V,F)
  % MY_NORMALS Compute *unnormalized* normals per face
  %
  % N = normals(V,F)
  % N = normals(V,F,'ParameterName',ParameterValue, ...)
  %
  % Inputs:
  %  V  #V x 3 matrix of vertex coordinates
  %  F  #F x 3  matrix of indices of triangle corners
  % Output:
  %  N  #F x 3 list of face normals
  
  [r_, c_] = size(F);  
  N = zeros(size(V));
  
  for i= 1:r_
      v1 = V(F(i, 1), :);
      v2 = V(F(i, 2), :);
      v3 = V(F(i, 3), :);
      e1 = v2 - v1;
      e2 = v3 - v2;
      N(i)= cross(e1, e2);
  end  
  
end
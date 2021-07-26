function k = my_discrete_gaussian_curvature(V,F)
  
  [r_, c_] = size(V);
  k = zeros(r_, 1);
  boundary_v = unique(outline(F));
  
  [rf_, c_] = size(F);
  for i = 1: rf_
      % [v0, v1, v2] = F(i,:);
      v0 = F(i,1);
      v1 = F(i,2);
      v2 = F(i,3);
      
      % if not on boundary, calculate angle
      if ~ismember(v0, boundary_v)
      
          e1 = V(v0, :) - V(v1, :);
          e2 = V(v0, :) - V(v2, :);      
          k(v0) = k(v0) + acos((e1 * e2') / (norm(e1) * norm(e2)));
      
      end 
      
      if ~ismember(v1, boundary_v)
      
          e1 = V(v1, :) - V(v0, :);
          e2 = V(v1, :) - V(v2, :);
          k(v1) = k(v1) + acos((e1 * e2') / (norm(e1) * norm(e2)));

      end 
      
      if ~ismember(v2, boundary_v)
      
          e1 = V(v2, :) - V(v1, :);
          e2 = V(v2, :) - V(v0, :);      
          k(v2) = k(v2) + acos((e1 * e2') / (norm(e1) * norm(e2)));
      
      end
      
  end
  
  k = k - (2 * pi);
  
  t = tsurf(F,V, 'CData',k);
    shading interp;
    axis equal;
    axis off;
    cm = flipud(cbrewer('RdYlBu', 500));
    colormap(cm(100:450,:));
    light('Position',[-1.5 1 1],'Style','local');
    lights = camlight;
    set(t, 'FaceLighting','gouraud', 'FaceColor','interp');
    set(t, 'DiffuseStrength',0.5, 'SpecularStrength',0.2, 'AmbientStrength',0.3);
    camproj('perspective');
    add_shadow([t],lights);

end
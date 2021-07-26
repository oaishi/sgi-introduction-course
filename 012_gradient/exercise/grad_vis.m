function L = grad_vis()
    [V, F] = readOBJ("../data/spot.obj");
    [r_, c_] = size(F);
    
    G = grad(V,F);
    G_sum = G * V(:,1); 
    disp(size(G_sum));
    G_sum = [];
    G_sum = [G_sum ; G([1:r_], :) * V(:,1)];
    G_sum = [G_sum ; G([(r_ + 1):(2*r_)], :) * V(:,2)];
    G_sum = [G_sum ; G([(((2*r_) + 1):(3*r_))], :) * V(:,3)];
    % G_sum = [G([1:r_], :) * V(:,1)  G([(r_ + 1):(2*r_)], :) * V(:,2) G([(((2*r_) + 1):(3*r_))], :) * V(:,3)]; % sum(G, 2);  
    disp(size(G_sum));
    
    Grad = [ G_sum(1:r_), G_sum((r_ + 1):(2*r_)), G_sum(((2*r_) + 1):(3*r_))];
    disp(size(Grad));
    qvr(barycenter(V,F), Grad);
    t = tsurf(F,V);
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
    hold on;
    qvr(barycenter(V,F), Grad);

end


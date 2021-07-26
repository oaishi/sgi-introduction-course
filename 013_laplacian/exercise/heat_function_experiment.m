function L = heat_function_experiment()
    [V, F] = readOBJ("../data/spot.obj");
    un = rand(size(V,1),1);
    L = -cotmatrix(V,F);
    M = massmatrix(V,F);
        
    for k = 1:100
        un = (1e-2*L + M) \ (M*un);
        %Plot the function u with the right colors.
        t = tsurf(F,V, 'CData',un);
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
        drawnow 
    end

end


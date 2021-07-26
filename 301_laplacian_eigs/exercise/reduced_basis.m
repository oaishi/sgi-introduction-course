% reduced_basis
clear all; close all; clc;

gptoolbox_path = ''; % complete
addpath(genpath(gptoolbox_path));

data_folder = '..\data\';
meshes = dir([data_folder,'*.o*']); % a list of all the meshes in the data folder
meshes = {meshes.name}; % access each mesh name by meshes{i}

cam_folder = [data_folder, 'cams\'];
cams = dir([cam_folder,'*.mat']); % a list of all the cam in the cams folder
cams = {cams.name};

addpath(data_folder); addpath(cam_folder);

[V, F] = readOBJ('..\data\homer.obj');
cam = cams{4};

figure(1)
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
    
%%
% Compute the eigendecomposition of the laplacian
W = -cotmatrix(V,F); % laplacian, the minus aign is for convention
A = massmatrix(V,F);

[r_, c_] = size(V);


% project the coordinate vectors onto the basis and back
for k = 10:10:100
    
    [phi, D] = eigs(W, A, k, -1e-5);  
    V_ = phi * (phi' * A * V);
    

    figure(2)
    %Plot the function u with the right colors.
    t = tsurf(F,V_);
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

% Visualize the reconstructed mesh 


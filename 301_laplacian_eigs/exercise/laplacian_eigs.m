% cot_lap_eigendecomposition
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


%% Task 1:
% load a few meshes using the readOFF or readOBJ function from gptoolbox,
% use lap_eig to compute its eigen decomposition and MESH_VIS to look at
% the eigenfunctions

% Remember  to adjust the colorbar to see all the eigenfunctions at the same scale

k = 6;
% [V, F] = readOFF('..\data\cat-00.off');
[V, F] = readOBJ('..\data\homer.obj');
[evals, evecs] = lap_eig(V, F, k);
%MESH_VIS.mesh(F,V); % does not use the saved cam
%MESH_VIS.mesh(F,V,'cam','..\data\cams\cat-00_cam.mat'); % uses the saved cam

figure(1)
for iter = 1:k
    subplot(1,k,iter)
    title(evals(iter));
    %Plot the function u with the right colors.
    t = tsurf(F,V, 'CData',evecs(:,iter));
    hold on
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
    % colorbar
end





%% Task 2:
% Rotation matrices:
rotx = @(ang) [1 0 0; 0 cos(ang) -sin(ang) ; 0 sin(ang) cos(ang)] ; % rotate about the x axis
roty = @(ang) [cos(ang) 0 sin(ang) ; 0 1 0 ; -sin(ang) 0  cos(ang)] ;
rotz = @(ang) [cos(ang) -sin(ang) 0 ; sin(ang) cos(ang) 0 ; 0 0 1] ;

% To rotate about the x axis by +pi/4: V_new = (rotx(pi/4)*V')'; 

% Compute the new vertices positions:
V_new = (rotx(pi/4)*V')' + [0,0,1];

% Compute the eigen decomposition of the new mesh - (V_new,F) and compare
% to the previous one

k = 6;
% [V, F] = readOFF('..\data\cat-00.off');
[V, F] = readOBJ('..\data\homer.obj');
[evals, evecs] = lap_eig(V, F, k);
%MESH_VIS.mesh(F,V); % does not use the saved cam
%MESH_VIS.mesh(F,V,'cam','..\data\cams\cat-00_cam.mat'); % uses the saved cam

figure(2)
for iter = 1:k
    subplot(1,k,iter)
    title(evals(iter));
    %Plot the function u with the right colors.
    t = tsurf(F,V, 'CData',evecs(:,iter));
    hold on
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


%% Task 3:
% Compute the eigendecompotision of:
% - two near-isometric shape, cat-00 and cat-01 
% - two non-isometric shapes cat-00 and lion-02

k = 6;
[V, F] = readOFF('..\data\cat-00.off');
[evals, evecs] = lap_eig(V, F, k);
%MESH_VIS.mesh(F,V); % does not use the saved cam
%MESH_VIS.mesh(F,V,'cam','..\data\cams\cat-00_cam.mat'); % uses the saved cam

figure(1)
for iter = 1:k
    subplot(1,k,iter)
    title(evals(iter));
    %Plot the function u with the right colors.
    t = tsurf(F,V, 'CData',evecs(:,iter));
    hold on
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

k = 6;
[V, F] = readOFF('..\data\cat-01.off');
[evals, evecs] = lap_eig(V, F, k);
%MESH_VIS.mesh(F,V); % does not use the saved cam
%MESH_VIS.mesh(F,V,'cam','..\data\cams\cat-00_cam.mat'); % uses the saved cam

figure(2)
for iter = 1:k
    subplot(1,k,iter)
    title(evals(iter));
    %Plot the function u with the right colors.
    t = tsurf(F,V, 'CData',evecs(:,iter));
    hold on
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

k = 6;
[V, F] = readOFF('..\data\lion-02.off');
[evals, evecs] = lap_eig(V, F, k);
%MESH_VIS.mesh(F,V); % does not use the saved cam
%MESH_VIS.mesh(F,V,'cam','..\data\cams\cat-00_cam.mat'); % uses the saved cam

figure(3)
for iter = 1:k
    subplot(1,k,iter)
    title(evals(iter));
    %Plot the function u with the right colors.
    t = tsurf(F,V, 'CData',evecs(:,iter));
    hold on
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



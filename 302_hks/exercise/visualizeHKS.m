% visualizeHKS
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

[V, F] = readOBJ('..\data\bunny.obj');

%% Compute the HKS:
[HKS, t] = heatKernelSignature(V, F);




%% Display the HKS on a few meshes for a small fixed time t.

k = 6;
figure(1)
for iter = 1:k
    subplot(1,k,iter)
    %Plot the function u with the right colors.
    t = tsurf(F,V, 'CData',HKS(:,iter*10));
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




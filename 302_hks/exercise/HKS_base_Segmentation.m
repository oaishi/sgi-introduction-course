% GPS_match
clear all; close all; clc;

data_folder = '..\data\';
meshes = dir([data_folder,'*.o*']); % a list of all the meshes in the data folder
meshes = {meshes.name}; % access each mesh name by meshes{i}

cam_folder = [data_folder, 'cams\'];
cams = dir([cam_folder,'*.mat']); % a list of all the cam in the cams folder
cams = {cams.name};

addpath(data_folder); addpath(cam_folder);

[V, F] = readOFF('..\data\cat-01.off');
cam = cams{1};




%% USe k-means algorithm (clustering algorithm) to segment the shape based on the GPS and visualize the results
% Hint: use Matlab's kmeans function.
% Try 5 or 6 segments for the armadillo.
% Feel free to try it with other meshes as well!

k = 5;
d = 5; % GPS embedding dimention
[HKS, t] = heatKernelSignature(V, F);

rng(1); % For reproducibility
[idx,C] = kmeans(HKS, d);

disp(size(idx));

t = tsurf(F, V, 'CData', idx);
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




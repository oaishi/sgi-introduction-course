% GPS_match
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

[V1, F1] = readOFF('..\data\cat-00.off');
[V2, F2] = readOFF('..\data\cat-01.off');
cam1 = cams{3};
cam2 = cams{4};


%%
% Compute descriptors
[HKS1, t1] = heatKernelSignature(V1, F1);
[HKS2, t2] = heatKernelSignature(V2, F2);

% Select a few landmarks on M1
% To easily select landmarks use: MESH_VIS.selectLandmark(F1,V1)
LankmarksInd = [3048; 1994; 6621; 5560];

% Find the matching vertices on M2 by finding signatures that are
% closest (in L2 sense) to the signatures of the given landmarks.
% Hint: knnsearch

closestPoints = knnsearch(HKS2, HKS1(LankmarksInd,:)); % [3048; 1994; 6621; 5560];
disp(closestPoints);

% Visualize the correspondence
figure;
MESH_VIS.displayp2pCorrespondence(F1, V1, F2, V2, [LankmarksInd, closestPoints],'cam1',cam1,'cam2',cam2);


% You can try this for additional landmarks.
% Or compute a full map by finding a matching vertex on M2 for each vertex
% of M1





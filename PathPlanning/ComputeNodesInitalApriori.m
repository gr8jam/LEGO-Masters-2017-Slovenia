clear all
close all

global Nodes PolygonMapColors
% addpath('..\PolygonMap')
% addpath('..\Sensors')
% addpath('..\Enviroment')
% addpath('..\TrueWorld')
addpath('..\Plotting')


Nodes = [];
% PolygonMapColors = [];

load('Nodes');
% load('PolygonColorData.mat');


for i = 1:96
    
    
    Nodes(i).Apriori = 1/96;
    Nodes(i).Aposteriori = 1/96;
    
%     Nodes(i).Aprio = 1/96;
%     Nodes(i).Apost = 1/96;
    
    
end


% save('Nodes.mat','Nodes');

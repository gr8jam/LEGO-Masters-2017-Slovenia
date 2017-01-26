close all;
clear all;

global Nodes d_max_tr_1 d_max_tr_2 d_max_tr_3 PolygonMapColors
d_max_tr_1 = 0;
d_max_tr_2 = 0;
d_max_tr_3 = 0;
Nodes = [];
PolygonMapColors = [];

addpath('..\PolygonMap')

load('Nodes2');

fig = figure;
set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on;
load('PolygonColorData.mat')

wait =0;
%% Draw Polygon
colorMap = BarvnaLestvicaRGB/255;
DrawPolygonMapColors(fig,colorMap)
pause(wait);

%% Draw Polygon with Pastel colors
% clf;
% colorMap = BarvnaLestvicaRGB_pastel;
% DrawPolygonMapColors(fig,colorMap)
% pause(wait);

%%
clf;
colorMap = [0 0 0] + 0.65;
DrawPolygonMapColors(fig,colorMap)
pause(0);

%% Show all nodes as red dots
DrawNodesPositions(fig, Nodes, 0);
pause(0);
DrawNodesConnections(fig);

%%















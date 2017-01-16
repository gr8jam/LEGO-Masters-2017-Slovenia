close all;
clear all;

global Nodes PolygonMapColors
Nodes = [];
PolygonMapColors = [];

load('Nodes');

fig = figure;
set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on;
load('../PolygonColorData.mat')

wait =0;
%% Draw Polygon
colorMap = BarvnaLestvicaRGB/255;
DrawPolygonMapColors(fig,colorMap)
pause(0);

%% Draw Polygon with Pastel colors
% clf;
% colorMap = BarvnaLestvicaRGB_pastel;
% DrawPolygonMapColors(fig,colorMap)
% pause(wait);

%%
clf;
colorMap = [0 0 0] + 0.70;
DrawPolygonMapColors(fig,colorMap)
pause(0);

%% Draw Nodes postions
DrawNodesPositions(fig, Nodes, 0/96)
pause(2);

%% Draw Nodes orientations
DrawInitalPoses(fig,4/96);
















close all;
clear all;

addpath('..\')
addpath('..\Obstacles')
addpath('..\Nodes')
addpath('..\PolygonMap')
load('Nodes2');
load('PolygonColorData.mat')

fig = figure;
FigureSettings(fig,'matej');

wait =0;
%% Draw Polygon
% ColorMap = BarvnaLestvicaRGB/255;
% DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)
% pause(wait);

%% Draw Polygon with Pastel colors
ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)
pause(wait);

%% Draw Enviroment and KeepOut
Walls = InitWalls();
Obstacles = InitObstacles(2);
KeepOut = InitKeepOut(Walls, Obstacles);

DrawWalls(fig, Walls)
DrawObstacles(fig, Obstacles);
DrawKeepOut(fig, KeepOut);

%% Draw Gray polygon
% clf;
% ColorMap = [0 0 0] + 0.65;
% DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)
% pause(0);

%% Show all nodes as red dots
DrawNodesPositions(fig, Nodes, 0);
pause(0);
DrawNodesConnections(fig,Nodes);

%%















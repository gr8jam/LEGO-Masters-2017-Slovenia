clear all
close all

global Nodes PolygonMapColors
addpath('..\PolygonMap')
addpath('..\Sensors')
% addpath('..\Enviroment')
% addpath('..\TrueWorld')
addpath('..\Plotting')


Nodes = [];
PolygonMapColors = [];

load('Nodes');
load('PolygonColorData.mat');


ComputeNodesColors();

% save('Nodes.mat', 'Nodes')

fig = figure;
FigureSettings(fig,'matej');
wait =0;

%% Draw Polygon
ColorMap = BarvnaLestvicaRGB/255;
DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)

%% Draw Polygon with Pastel colors
% ColorMap = BarvnaLestvicaRGB_pastel;
% DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)

%% Draw Enviroment and KeepOut
% DrawWalls(fig, Walls)
% DrawObstacles(fig, TrueObstacleCenters);
% DrawKeepOut(fig, WallsKeepOut, 'r--');
% DrawKeepOut(fig, ObstaclesKeepOut, 'r--');

%% Show all nodes as red dots
ColorMap = BarvnaLestvicaRGB/255;
DrawNodesPositions(fig, Nodes, ColorMap, 0);


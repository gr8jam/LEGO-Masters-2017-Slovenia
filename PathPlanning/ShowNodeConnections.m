close all;
clear all;

global Nodes WallsKeepOut ObstaclesKeepOut

cd(fileparts(mfilename('fullpath')))

addpath('..\PolygonMap')
addpath('..\Sensors')
addpath('..\Enviroment')
addpath('..\TrueWorld')
addpath('..\Plotting')

Nodes = [];
PolygonMapColors = [];
Walls = [];
WallsKeepOut = [];

load('Nodes');
load('PolygonColorData.mat');
load('Walls');
load('WallsKeepOut');

TrueObstacleCenters = InitTrueObstacleCenters(2);
ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters, 140);


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
DrawWalls(fig, Walls)
DrawObstacles(fig, TrueObstacleCenters);
DrawKeepOut(fig, WallsKeepOut, 'r--');
DrawKeepOut(fig, ObstaclesKeepOut, 'r--');

%% Draw Gray polygon
% clf;
% ColorMap = [0 0 0] + 0.65;
% DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)
% pause(0);

%% Show all nodes as red dots
DrawNodesPositions(fig, Nodes, 0);
pause(0);

%% Recompute the nodes connections
RecomputeNodeConnections(fig,0,0,0);

%% Draw Nodes connections
DrawNodesConnections(fig,Nodes);




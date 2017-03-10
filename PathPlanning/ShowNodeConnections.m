close all;
clear all;

global Nodes WallsKeepOut ObstaclesKeepOut DistanceKeepOut_Obstacles

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
DistanceKeepOut_Obstacles = 50+70;

load('Nodes');
load('PolygonColorData.mat');
load('Walls');
load('WallsKeepOut');

TrueObstacleCenters = InitTrueObstacleCenters(2);
ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);


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
ColorMap = BarvnaLestvicaRGB_pastel;
DrawNodesPositions(fig, Nodes,ColorMap, 0);


%% Recompute the nodes connections
RecomputeNodeConnectionsBayesFilter(fig,true,0,0,true);

%% Draw Nodes connections
DrawNodesConnections(fig,Nodes);




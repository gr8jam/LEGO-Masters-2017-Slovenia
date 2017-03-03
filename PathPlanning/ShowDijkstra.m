close all;
clear all;

global Nodes WallsKeepOut ObstaclesKeepOut
global DistanceKeepOut_Obstacles 
global NodeConnectionDistanceMax
global NodeConnectionAngleLimit

cd(fileparts(mfilename('fullpath')))

addpath('..\PolygonMap')
% addpath('..\Sensors')
addpath('..\Enviroment')
addpath('..\TrueWorld')
addpath('..\Plotting')

Nodes = [];
PolygonMapColors = [];
Walls = [];
WallsKeepOut = [];

DistanceKeepOut_Obstacles = 50 + 90;
NodeConnectionDistanceMax = 500;
NodeConnectionAngleLimit = pi/2;

load('Nodes');
load('PolygonColorData.mat');
load('Walls');
load('WallsKeepOut');


fig = figure;
FigureSettings(fig,'matej');
wait =0;


% load('Nodes2');
% load('../PolygonMap/PolygonColorData.mat')
% load('Dijkstra_example_nodes');


%% Draw Polygon
% ColorMap = BarvnaLestvicaRGB/255;
% DrawPolygonMapColors(fig,PolygonMapColors, ColorMap)
% % pause(3);

%% Draw Polygon with Pastel colors
% clf;
ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)
% pause(3);

%% Draw Enviroment and KeepOut
TrueObstacleCenters = InitTrueObstacleCenters(2);
ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);

DrawWalls(fig, Walls)
DrawObstacles(fig, TrueObstacleCenters);
DrawKeepOut(fig, WallsKeepOut, 'r--');
DrawKeepOut(fig, ObstaclesKeepOut, 'r--');

%%
% clf;
% colorMap = [0 0 0] + 0.70;
% DrawPolygonMapColors(fig,colorMap)
% pause(0);

%% Draw Nodes postions
DrawNodesPositions(fig, Nodes, 0);
% pause(2);

%% Recompute the nodes connections
tic;
for i = 1:length(TrueObstacleCenters)
    x = TrueObstacleCenters(i,1);
    y = TrueObstacleCenters(i,2);
    
    RecomputeNodeConnections(fig,false,x,y);
    
end

%% Run Dijkstra Algorithm
StartIdx = 59;

ComputeDijkstra(StartIdx);
duration = toc
%% Obtain optimal path
StopIdx = 55;
OptimalPath = ComputeOptimalPathDijkstra(Nodes, StartIdx, StopIdx);

%% Highlight Start and End position
plot(Nodes(StartIdx).x,Nodes(StartIdx).y,'g.','MarkerSize',35)
% pause(1);
plot(Nodes(StopIdx).x,Nodes(StopIdx).y,'r.','MarkerSize',35)
% pause(4);

%% Draw optimal path
delay = 0;
DrawOptimalPathDijkstra(fig, Nodes, OptimalPath, delay);

axis([-200 2770 -200 1950])

% % % % save('Nodes.mat', 'Nodes')





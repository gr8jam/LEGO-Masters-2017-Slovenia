close all;
clear all;

global Nodes WallsKeepOut ObstaclesKeepOut
global DistanceKeepOut_Obstacles 
global NodeConnectionDistanceMax
global NodeConnectionAngleLimit
global PP

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
NodeConnectionDistanceMax = 700;
NodeConnectionAngleLimit = pi/2;
PP = InitPathPlanning();

TrueObstacleCenters = InitTrueObstacleCenters(2);
ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);


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

%% Draw Nodes postions
ColorMap = BarvnaLestvicaRGB_pastel;
DrawNodesPositions(fig, Nodes, ColorMap,0);
% pause(2);

%%
% clf;
% colorMap = [0 0 0] + 0.70;
% DrawPolygonMapColors(fig,colorMap)
% pause(0);

%% Recompute the nodes connections
% ComputeNodeConnections(fig,false);

DRAW = false;
all = true;
init = false;
RecomputeNodeConnections(fig,DRAW,0,0,all,init);

% for i = 1:length(TrueObstacleCenters)
%     x = TrueObstacleCenters(i,1);
%     y = TrueObstacleCenters(i,2);
%     tic;
%     RecomputeNodeConnections(fig,false,x,y,false);
%     duration = toc;
% %     fprintf('Duration = %1.3f s\n', duration);
% end

%% Run Dijkstra Algorithm
StartIdx = 57;

ComputeDijkstra(StartIdx);

%% Obtain optimal path
StopIdx = 56;
ComputeOptimalPathDijkstra(StartIdx, StopIdx);
OptimalPath = PP.Path;

%% Draw Connections of the nodes on path
DrawAllConnection(fig, Nodes);

%% Highlight Start and End position
Color = [0, 200, 51]/255;
plot(Nodes(StartIdx).x,Nodes(StartIdx).y,'.','Color',Color,'MarkerSize',35)
% pause(1);
plot(Nodes(StopIdx).x,Nodes(StopIdx).y,'r.','MarkerSize',35)
% pause(4);

%% Draw optimal path
delay = 0;
DrawOptimalPathDijkstra(fig, Nodes, PP, delay);
axis([-70 2770 -200 1950])
% save('Nodes.mat', 'Nodes')


%% Draw Enviroment and KeepOut
DrawWalls(fig, Walls)
DrawObstacles(fig, TrueObstacleCenters);
DrawKeepOut(fig, WallsKeepOut, 'r--');
DrawKeepOut(fig, ObstaclesKeepOut, 'r--');




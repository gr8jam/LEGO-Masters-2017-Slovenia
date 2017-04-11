close all;
clear all;

global Nodes WallsKeepOut ObstaclesKeepOut DistanceKeepOut_Obstacles
global NodeConnectionDistanceMax NodeConnectionAngleLimit

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
NodeConnectionDistanceMax = 450;
NodeConnectionAngleLimit = pi/2;

load('Nodes');
load('PolygonColorData.mat');
load('Walls');
load('WallsKeepOut');



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

%% Draw nodes
ColorMap = BarvnaLestvicaRGB_pastel;
DrawNodesPositions(fig, Nodes,ColorMap, 0);

%% Draw Enviroment and KeepOut
TrueObstacleCenters = InitTrueObstacleCenters(2);
ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);

DrawWalls(fig, Walls)
DrawObstacles(fig, TrueObstacleCenters);
DrawKeepOut(fig, WallsKeepOut, 'r--');
DrawKeepOut(fig, ObstaclesKeepOut, 'r--');

%% Draw Gray polygon
% clf;
% ColorMap = [0 0 0] + 0.65;
% DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)
% pause(0);


%% Recompute the nodes connections
DRAW = false;
all = true;
init = true;
RecomputeNodeConnections(fig,DRAW,0,0,all,init);

% DRAW = false;
% all = false;
% init = false;
% for i = 1:4
%     x = TrueObstacleCenters(i,1);
%     y = TrueObstacleCenters(i,2);
%     RecomputeNodeConnections(fig,DRAW,x,y,all,init);
% end

DRAW = false;
all = true;
init = true;
RecomputeNodeConnectionsBayesFilter(fig,DRAW,0,0,all,init);


%% Draw Nodes connections
% DrawNodesConnections(fig,Nodes);
% DrawNodesConnectionsBayesFilter(fig,Nodes);
axis([-70 2770 -200 1950])

%% Highlight current node
Color = [0 230 51]/255;
%     Color = [255 0 102]/255;
Color = 'g';
plot(Nodes(5).x,Nodes(5).y,'.','Color',Color,'MarkerSize',25)

%% Draw Nodes connections
DrawAllConnection(fig, Nodes);
DrawAllConnectionBayesFilter(fig, Nodes);



% % % % % save('Nodes.mat', 'Nodes');






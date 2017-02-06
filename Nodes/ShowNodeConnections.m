close all;
clear all;


addpath('..\Obstacles')
addpath('..\Nodes')
addpath('..\PolygonMap')
load('Nodes2');


screensize = get( groot, 'Screensize' );
W_screen = screensize(3);
H_screen = screensize(4);
W = W_screen/1.1;
H = 18/25 * W;

fig = figure;
set(fig, 'Position', [0 H_screen-H W H]); %% matej
hold on;
load('PolygonColorData.mat')

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















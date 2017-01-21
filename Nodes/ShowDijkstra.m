close all;
clear all;

global Nodes PolygonMapColors
Nodes = [];
PolygonMapColors = [];


load('Nodes');
load('../PolygonColorData.mat')
% load('Dijkstra_example_nodes');

fig = figure;
set(fig, 'Position', [1600 -150 24*60 19*60]); %% matej
% axis([-1 4 -1 3]);
hold on;

%% Draw Polygon
colorMap = BarvnaLestvicaRGB/255;
DrawPolygonMapColors(fig,colorMap)
pause(3);

%% Draw Polygon with Pastel colors
% clf;
colorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,colorMap)
pause(3);

%%
% clf;
% colorMap = [0 0 0] + 0.70;
% DrawPolygonMapColors(fig,colorMap)
% pause(0);

%% Draw Nodes postions
DrawNodesPositions(fig, Nodes, 0);
pause(2);

%% Run Dijkstra Algorithm
StartIdx = 73;
ComputeDijkstra(StartIdx);

%% Obtain optimal path
StopIdx = 41;
OptimalPath = ComputeOptimalPathDijkstra(Nodes, StartIdx, StopIdx);

%% Highlight Start and End position
plot(Nodes(StartIdx).x,Nodes(StartIdx).y,'g.','MarkerSize',35)
pause(1);
plot(Nodes(StopIdx).x,Nodes(StopIdx).y,'r.','MarkerSize',35)
pause(4);

%% Draw optimal path
delay = 0.4;
DrawOptimalPathDijkstra(fig, Nodes, OptimalPath, delay);






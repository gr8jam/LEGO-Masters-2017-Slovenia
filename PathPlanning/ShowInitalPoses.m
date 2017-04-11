% close all;
% clear all;

global Nodes PolygonMapColors
Nodes = [];
PolygonMapColors = [];

addpath('..\PolygonMap')
% addpath('..\Sensors')
addpath('..\Enviroment')
addpath('..\TrueWorld')
addpath('..\Plotting')

% fig = figure;
% FigureSettings(fig,'matej');
wait =0;
% 
% fig = figure;
% set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
% hold on;


load('Nodes');
load('PolygonColorData.mat');
load('Walls');

wait =0;
%% Draw Polygon with Pastel colors
ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)


%% Draw Enviroment and KeepOut
DrawWalls(fig, Walls)
% DrawObstacles(fig, TrueObstacleCenters);
% DrawKeepOut(fig, WallsKeepOut, 'r--');
% DrawKeepOut(fig, ObstaclesKeepOut, 'r--');

%% Draw Nodes orientations
DrawInitalPoses(fig);

%% Draw Nodes postions
ColorMap = BarvnaLestvicaRGB/255;
DrawNodesPositions(fig, Nodes, ColorMap);


%%
axis([-100 2700 -50 1820])












clear all;
close all;

addpath('..\PolygonMap')
addpath('..\TrueWorld')

load('PolygonColorData.mat');

% load('Walls.mat')
% load('KeepOutWalls.mat')

load('TrueObstacleCenters.mat');

Obstacles = ComputeObstacles(TrueObstacleCenters, 50);
KeepOutObstacles = ComputeObstacles(TrueObstacleCenters, 105);

fig = figure;
set(fig, 'Position', [0 170 25*35 18*35]); %% matej
hold on;

DrawPolygonMapColors(fig,PolygonMapColors,BarvnaLestvicaRGB_pastel);
% DrawWalls(fig, Walls)
% DrawKeepOut(fig, KeepOutWalls);

DrawObstacles(fig, TrueObstacleCenters);
DrawKeepOut(fig, Obstacles);
DrawKeepOut(fig, KeepOutObstacles);
clear all;
close all;

addpath('..\PolygonMap')
addpath('..\TrueWorld')

load('PolygonColorData.mat');

load('Walls.mat')

% load('TrueObstacleCenters.mat');


fig = figure;
set(fig, 'Position', [0 170 25*35 18*35]); %% matej
hold on;

DrawPolygonMapColors(fig,PolygonMapColors,BarvnaLestvicaRGB_pastel);
DrawWalls(fig, Walls)

% DrawKeepOut(fig, KeepOutWalls);
% DrawObstacles(fig, TrueObstacleCenters);
% DrawKeepOut(fig, Obstacles);
% DrawKeepOut(fig, KeepOutObstacles);
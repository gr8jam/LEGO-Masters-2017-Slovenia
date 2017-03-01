clear all;
close all;

addpath('..\PolygonMap')
load('PolygonColorData.mat');

addpath('..\TrueWorld')

TrueWalls = InitTrueWalls();
TrueObstacleCenters = InitTrueObstacleCenters(2);
TrueKeepOut = InitTrueKeepOut(TrueWalls, TrueObstacleCenters);

fig = figure;
set(fig, 'Position', [0 170 25*35 18*35]); %% matej
hold on;

DrawPolygonMapColors(fig,PolygonMapColors,BarvnaLestvicaRGB_pastel);
DrawWalls(fig, TrueWalls)
DrawObstacles(fig, TrueObstacleCenters)
DrawKeepOut(fig, TrueKeepOut, 'r--');
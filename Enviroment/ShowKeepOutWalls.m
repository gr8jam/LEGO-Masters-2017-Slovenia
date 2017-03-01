clear all;
close all;

addpath('..\PolygonMap')
load('PolygonColorData.mat');


Walls = InitWalls();


load('Walls.mat')
load('KeepOutWalls.mat')


fig = figure;
set(fig, 'Position', [0 170 25*35 18*35]); %% matej
hold on;

DrawPolygonMapColors(fig,PolygonMapColors,BarvnaLestvicaRGB_pastel);
DrawWalls(fig, Walls)
DrawKeepOut(fig, KeepOutWalls);
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
addpath('..\PathPlanning')

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

%% Draw Polygon with Pastel colors
ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)
pause(wait);

%% Draw nodes
% ColorMap = BarvnaLestvicaRGB_pastel;
% DrawNodesPositions(fig, Nodes,ColorMap, 0);

%% Draw Enviroment and KeepOut
% TrueObstacleCenters = InitTrueObstacleCenters(2);
% ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);
% 
% DrawWalls(fig, Walls)
% DrawObstacles(fig, TrueObstacleCenters);
% DrawKeepOut(fig, WallsKeepOut, 'r--');
% DrawKeepOut(fig, ObstaclesKeepOut, 'r--');


%%
global BF SenRGB
BF = InitBayesFilter();

hhBF = BF;
for i = 1:96
    x = Nodes(i).x;
    y = Nodes(i).y;
    hhBF.Apost(i) = plot(x,y,'ko','LineWidth',2, 'MarkerSize', 1, 'erasemode','xor');
end

Color = [255, 110, 0]/255;  % orange
hhBF.bestMtcIdx = plot(0,0,'.', 'Color',Color,'erasemode','xor');




% Nodes = [];
% TestNodes;
% BF.Aprio = [0 0 0 0]';
% BF.Apost = [0.7 0.1 0.1 0.1]';


% BayesFilter();

% BF.Flag_Forward = true;

fprintf('\n\nApriori sum: %3.5f \n',sum(BF.Aprio));
BF.Flag_NewMotion = true;
SenRGB.Right.ChangedFil = true;


n = 10;
for j = 1:96
    
    
    if (n == 17)
        n = n + 32 + 1;
        BF.Flag_Forward = false;
        BF.Flag_TurnLeft = true;
        BF.Flag_TurnRight = false;
    elseif (n == 64)
        n = 65;
        BF.Flag_Forward = false;
        BF.Flag_TurnLeft = true;
        BF.Flag_TurnRight = false;
    elseif (n == 70)
        n = n - 32;
        BF.Flag_Forward = false;
        BF.Flag_TurnLeft = false;
        BF.Flag_TurnRight = true;
    else
        n = n + 1;
        BF.Flag_Forward = true;
        BF.Flag_TurnLeft = false;
        BF.Flag_TurnRight = false;
    end
    
    
    BF.Flag_NewMotion = true;
    SenRGB.Right.ChangedFil = true;
    SenRGB.Right.idxFil = Nodes(n).idxColor;
    fprintf('Color idx: %d \n', Nodes(n).idxColor);
    

    BayesFilter(); 
    fprintf('Apriori sum: %3.5f \n',sum(BF.Aprio));
    fprintf('Aprosteriori sum: %3.5f \n',sum(BF.Apost));
    
    for i = 1:96
        set(hhBF.Apost(i), 'MarkerSize', BF.Apost(i)*50);
    end
    
    if (BF.bestMtcIdx ~= 0)
        x = Nodes(BF.bestMtcIdx).x;
        y = Nodes(BF.bestMtcIdx).y;
        size = BF.Apost(BF.bestMtcIdx)*100;
    else
        x = 0;
        y = 0;
        size = 1;
    end
    set(hhBF.bestMtcIdx, 'XData',x,'YData',y,'MarkerSize',size);
    fprintf('BF.bestMtcVal: %3.2f \n',BF.bestMtcVal);
    
end













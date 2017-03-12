% [qqqTrue qqq] = RaceSimulation();
load('RaceSimulation_Output.mat');
close all;
%%
global Nodes WallsKeepOut ObstaclesKeepOut TrueObstacleCenters
global DistanceKeepOut_Obstacles 
global NodeConnectionDistanceMax
global NodeConnectionAngleLimit
global PP

% cd(fileparts(mfilename('fullpath')))

addpath('..\PolygonMap')
% addpath('..\Sensors')
addpath('..\Enviroment')
addpath('..\TrueWorld')
addpath('..\Plotting')

% Nodes = [];
% PolygonMapColors = [];
% Walls = [];
% WallsKeepOut = [];
% 
% DistanceKeepOut_Obstacles = 50 + 90;
% NodeConnectionDistanceMax = 700;
% NodeConnectionAngleLimit = pi/2;
% PP = InitPathPlanning();
% 
% TrueObstacleCenters = InitTrueObstacleCenters(2);
% ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);
% 
% 
% load('Nodes');
% load('PolygonColorData.mat');
% load('Walls');
% load('WallsKeepOut');
% 

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

%% Draw Enviroment and KeepOut
DrawWalls(fig, Walls)
DrawObstacles(fig, TrueObstacleCenters);
DrawKeepOut(fig, WallsKeepOut, 'r--');
DrawKeepOut(fig, ObstaclesKeepOut, 'r--');

axis([-70 2770 -200 1950])


%% Draw TrueRobot path and estimation
tt = 1:1428;

Color = 'b';
% Color = [255, 110, 0]/255;
plot(qqqTrue(1,tt),qqqTrue(2,tt),'-','Color',Color, 'LineWidth', 4);

xs = qqqTrue(1,tt(end-5));
ys = qqqTrue(2,tt(end-5));
xe = qqqTrue(1,tt(end));
ye = qqqTrue(2,tt(end));

[x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,pi/6,75);
plot([xs xe x_arrow],[ys ye y_arrow],'-','Color',Color,'LineWidth', 3);

pnts = [50 300 540 850 1040 1200];
for i = 1:length(pnts)
    
    pnt = pnts(i);
    xs = qqqTrue(1,tt(pnt-5));
    ys = qqqTrue(2,tt(pnt-5));
    xe = qqqTrue(1,tt(pnt));
    ye = qqqTrue(2,tt(pnt));

    [x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,pi/6,75);
    plot([xs xe x_arrow],[ys ye y_arrow],'-','Color',Color, 'LineWidth', 3);
end





    
% Color = 'm';
Color = [255, 110, 0]/255;
% Color = [0 164 58]/255; 
% Color = 'b';

plot(        qqq(1,tt),qqq(2,tt),'--', 'LineWidth', 3,'Color',Color);




for i = 1:length(pnts)
    pnt = pnts(i);
    xs = qqq(1,tt(pnt-5));
    ys = qqq(2,tt(pnt-5));
    xe = qqq(1,tt(pnt));
    ye = qqq(2,tt(pnt));

    [x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,pi/6,75);
    plot([xs xe x_arrow],[ys ye y_arrow],'-','Color',Color, 'LineWidth', 3);
end

xs = qqq(1,tt(end-5));
ys = qqq(2,tt(end-5));
xe = qqq(1,tt(end));
ye = qqq(2,tt(end));
[x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,pi/6,75);
plot([xs xe x_arrow],[ys ye y_arrow],'-', 'LineWidth', 3,'Color',Color);

xlabel('x [mm]'),ylabel('y [mm]')




%% Highlight Start and End position
StartIdx = 84;
Color = [0, 200, 51]/255;
plot(Nodes(StartIdx).x,Nodes(StartIdx).y,'.','Color',Color,'MarkerSize',35)

StopIdx = 56;
plot(Nodes(StopIdx).x,Nodes(StopIdx).y,'r.','MarkerSize',35)



%%

tt = 1:1428;
tt = 1:550;

time = tt .* 0.033;

figure
subplot(3,1,1)
hold on;
Color = 'b';
plot(time,qqqTrue(1,tt),'-','Color',Color, 'LineWidth', 2);
Color = [255, 110, 0]/255;
plot(time,qqq(1,tt),'--','Color',Color, 'LineWidth', 2);
xlabel('t [s]'),ylabel('x [mm]')


subplot(3,1,2)
hold on;
Color = 'b';
plot(time,qqqTrue(2,tt),'-','Color',Color, 'LineWidth', 2);
Color = [255, 110, 0]/255;
plot(time,qqq(2,tt),'--','Color',Color, 'LineWidth', 2);
xlabel('t [s]'),ylabel('y [mm]')

qqqT = qqqTrue;
% qqqT(3,bool & bool2) = qqqT(3,bool & bool2) - 2*pi;
qqqT(3,785:809) = - pi;


subplot(3,1,3)
hold on;
Color = 'b';
plot(time,qqqT(3,tt),'-','Color',Color, 'LineWidth', 2);
Color = [255, 110, 0]/255;
plot(time,qqq(3,tt),'--','Color',Color, 'LineWidth', 2);
xlabel('t [s]'),ylabel('fi [rad]')



% save('RaceSimulation_Output.mat', 'qqqTrue','qqq');


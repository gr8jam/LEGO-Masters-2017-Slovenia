function Robot = InitEV3()


global PolygonMapColors
global Walls WallsKeepOut
global ObstaclesCenters Obstacles ObstaclesKeepOut
global DistanceKeepOut_Obstacles
global NodeConnectionDistanceMax NodeConnectionAngleLimit
global Nodes
global PF 
global PP
global MC
global ED
global SenRGB SenDist SenGyro


PolygonMapColors = [];
Walls = []; 
WallsKeepOut  = [];
Nodes = [];

load('PolygonMap/PolygonColorData.mat');
load('Enviroment/Walls.mat');
load('Enviroment/WallsKeepOut.mat');
load('PathPlanning/Nodes.mat');

ObstaclesCenters = zeros(4,2);
Obstacles = zeros(32,4);
ObstaclesKeepOut = zeros(32,4);

% DEFINE MACRO
DistanceKeepOut_Obstacles = 50 + 90;
NodeConnectionDistanceMax = 700;
NodeConnectionAngleLimit = pi/2;

PF = InitParticleFilter();
PP = InitPathPlanning();
MC = InitMotionControler();

SenRGB = InitSenRGB();
SenDist = InitSenDist();
SenGyro = InitSenGyro();

Robot = struct('Walls',Walls,...
               'WallsKeepOut', WallsKeepOut,...
               'ObstaclesCenters', ObstaclesCenters,...
               'Obstacles', Obstacles,...
               'ObstaclesKeepOut', ObstaclesKeepOut,...
               'Nodes', Nodes,...
               'PF', PF,...
               'PP', PP,...
               'MC', MC,...
               'ED', ED,...
               'SenRGB', SenRGB,...
               'SenDist', SenDist,...
               'SenGyro', SenGyro); 
           
%                'DistanceKeepOut_Obstacles',DistanceKeepOut_Obstacles,...
%                'NodeConnectionDistanceMax',NodeConnectionDistanceMax,...
%                'NodeConnectionAngleLimit',NodeConnectionAngleLimit,...
%                'Path', Path,...
%                'Goal', Goal,...
           
end




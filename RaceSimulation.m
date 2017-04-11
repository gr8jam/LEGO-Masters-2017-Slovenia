function [qqqTrue_out, qqqPF_out] = RaceSimulation()
close all;
clear all; 

cd(fileparts(mfilename('fullpath')))

addpath('Localization');
addpath('EV3');
addpath('Controler');
addpath('PathPlanning');
addpath('Sensors');
addpath('PolygonMap');
addpath('Enviroment');
addpath('TrueWorld');
addpath('Plotting');
addpath('Pipe');


%% Changed user for prefered figure settings
global user
user = 'matej';
% user = 'peter';

%% Simulation time, Sampling rate
global Ts 
Ts=0.033;               % sampling time
Tend = 15; % 53.85;      % Simulation end time
t=0:Ts:Tend;            % time vector

%% Global storage of different data
global qqqTrue qqqPF qqqSF xxxPF vvv www ttt
qqqTrue = -1 * ones(3,length(t));   % Robot real states
qqqPF = -1 * ones(3,length(t));     % Robot estimated states (Particel Filter)
xxxPF = [];                         % Particle Filter particles states at certain moment
qqqSF = -1 * ones(3,length(t));     % Robot estimated state (Simple Filter)
vvv = -1 * ones(1,length(t));       % Robot translator speed
www = -1 * ones(1,length(t));       % Robot angular speed
ttt = -1 * ones(1,length(t));       % Time vector

%% Real enviroment data
global TrueWalls TrueObstacleCenters TrueObstacles TrueKeepOut
StartModeObst = 2;
if StartModeObst == 1
    InitGrafic();
end
TrueObstacleCenters = InitTrueObstacleCenters(StartModeObst);
TrueObstacles = ComputeObstacles(TrueObstacleCenters, 50);
TrueWalls = InitTrueWalls();
TrueKeepOut = InitTrueKeepOut(TrueWalls, TrueObstacleCenters);

%% Plot handels
global hFigMap hFigRGB
hFigMap = [];
hFigRGB = [];

%% Global data for line follower
% global stanje stanjeend        % naèin delovanja
% stanje = zeros(1);             % naèin delovanja
% stanjeend = zeros(1);

%% Polygon Map data
global PolygonMapColors BarvnaLestvicaRGB BarvnaLestvicaHSV BarvnaLestvicaRGB_pastel 
PolygonMapColors  = [];
BarvnaLestvicaRGB = [];
BarvnaLestvicaHSV = [];
BarvnaLestvicaRGB_pastel = [];
load('PolygonMap/PolygonColorData.mat')

%% Nodes data
global Nodes
Nodes = [];
load('PathPlanning/Nodes.mat');

%% Variables describing real robot and simulated robot
global TrueRobot Robot
StartModeTrueRobot = 4;
if StartModeTrueRobot == 1
    InitGrafic();
end
TrueRobot = InitTrueRobot(StartModeTrueRobot);


%% Simulation
InitGrafic();

time_debug_stop = 7;
tic;
for i=1:length(t)
    
    if (i*Ts > time_debug_stop)
        time_debug_stop = time_debug_stop + 8;
%         UpdateGrafic();
%         i*Ts
    end
    
    SimulateEV3(i);
    
    v = Robot.MC.v;
    w = Robot.MC.w;
    SimulateTrueRobot(v,w);
    
    StoreData(i);
    UpdateGrafic(i);
    
%      pause(0.03);
%     if (ttt(i) > 30)
%       pause(0.03);
%     end   
end
duration = toc;
fprintf('Simulated %i sec, simulation finished in %i sec. \n', Tend, int32(duration));

%% Draw robot path
figure
hold on;
plot(qqqTrue(1,:),qqqTrue(2,:),'b');
plot(qqqPF(1,:),qqqPF(2,:),'g--');
plot(qqqSF(1,:),qqqSF(2,:),'r-.')
xlabel('x [mm]'),ylabel('y [mm]')
hold off;

%% Draw speed and angular speed
figure
subplot(2,1,1)
plot(ttt,vvv,'-');
xlabel('t [s]'),ylabel('v [mm/s]');
subplot(2,1,2)
plot(ttt,www,'-');
xlabel('t [s]'),ylabel('omega [rad/s]');

%% Race Simulation output
% qqqTrue_out = qqqTrue;
% qqqPF_out = qqqPF;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% FUNKCIJE    %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function StoreData(i)
global TrueRobot Robot Ts
global qqqTrue qqqPF qqqSF xxxPF vvv www ttt

qqqTrue(:,i) = TrueRobot.q;
if (~isempty(Robot))
    q = [Robot.PF.x Robot.PF.y Robot.PF.fi]'; % X Robot.Y Robot.Fi]';
    qqqPF(:,i) = q; % = [qqqPF q];
    
    if (~isempty(Robot.PF.xParticles))
        xxxPF = Robot.PF.xParticles;
    end
    
    vvv(i) = Robot.MC.v;
    www(i) = Robot.MC.w;
    ttt(i) = Ts*i;
    
    if (Robot.SF.bestMtcIdx ~= 0)
        idx = Robot.SF.bestMtcIdx;
        x = Robot.Nodes(idx).x;
        y = Robot.Nodes(idx).y;
        fi = Robot.Nodes(idx).fi;
        q = [x y fi]'; % X Robot.Y Robot.Fi]';
        qqqSF(:,i) = q; 
    end
    
end

end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
function UpdateGrafic(i)

persistent cnt
if (isempty(cnt))
    cnt = 0;
end

cnt = cnt + 1;
if (mod(cnt,5) == 0)
    cnt = 0;
    UpdateGrafic_FigMap(i);   
    UpdateGrafic_FigRGB();
    drawnow;
end

end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
function InitGrafic()

InitGrafic_FigMap();
InitGrafic_FigRGB();

end







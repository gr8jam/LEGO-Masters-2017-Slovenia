function [qqqTrue_out qqqPF_out] = RaceSimulation
close all, clear all 

cd(fileparts(mfilename('fullpath')))

addpath('Localization');
addpath('Controler');
addpath('PathPlanning');
addpath('Sensors');
addpath('PolygonMap');
addpath('Enviroment');
addpath('TrueWorld');
addpath('Plotting');
addpath('Pipe');
addpath('Stack');


global Ts 
global TrueWalls TrueObstacleCenters TrueObstacles TrueKeepOut 
global TrueRobot Robot

%% Plot handels
global hFigMap hFigRGB
hFigMap = [];
hFigRGB = [];

%% Global storage of different data
global qqqTrue qqqPF qqqSF xxxPF vvv www ttt
qqqTrue = [];   % Robot real states
qqqPF = [];     % Robot estimated states (Particel Filter)
xxxPF = [];     % Robot particles at certain moment
vvv = [];       % Robot translator speed
www = [];       % Robot angular speed
ttt = [];       % Time vector

global user
user = 'matej';
% user = 'peter';

% global stanje stanjeend        % naèin delovanja
% stanje = zeros(1);             % naèin delovanja
% stanjeend = zeros(1);

global PolygonMapColors BarvnaLestvicaRGB BarvnaLestvicaHSV BarvnaLestvicaRGB_pastel 
PolygonMapColors  = [];
BarvnaLestvicaRGB = [];
BarvnaLestvicaHSV = [];
BarvnaLestvicaRGB_pastel = [];
load('PolygonMap/PolygonColorData.mat')

global Nodes
Nodes = [];
load('PathPlanning/Nodes.mat');



%% Init
Tend = 15; % 53.85;      % Simulation end time
Ts=0.033;       % sample time
t=0:Ts:Tend;    % time vector
% U=[];Tvzorcenja=[] ;Z=[];




% DRAW_MORE = 1;
StartModeRobot = 4;
if StartModeRobot == 1
    InitGrafic();
end

StartModeObst = 2;
if StartModeObst == 1
    InitGrafic();
end

load('TrueWalls.mat')
load('TrueObstaclesCenters.mat')

TrueRobot = InitTrueRobot(StartModeRobot);
TrueWalls = InitTrueWalls();
TrueObstacleCenters = InitTrueObstacleCenters(StartModeObst);
TrueObstacles = ComputeObstacles(TrueObstacleCenters, 50);
TrueKeepOut = InitTrueKeepOut(TrueWalls, TrueObstacleCenters);

InitGrafic();

% StoreData();
% UpdateGrafic();

%% Simulation

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
    
    StoreData();
    ttt = [ttt Ts*i];
    UpdateGrafic();
    
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

% qqqTrue_out = qqqTrue;
% qqqPF_out = qqqPF;

% figure
% plot(Tvzorcenja,Z(:,1),Tvzorcenja,Z(:,2),Tvzorcenja,Z(:,3),'--')
% xlabel('t [s]'),ylabel('d [m/s]'),legend('d1','d2','d3'),
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% FUNKCIJE    %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function StoreData
global TrueRobot Robot
global qqqTrue qqqPF qqqSF xxxPF vvv www

qqqTrue = [qqqTrue TrueRobot.q];
if (~isempty(Robot))
    q = [Robot.PF.x Robot.PF.y Robot.PF.fi]'; % X Robot.Y Robot.Fi]';
    qqqPF = [qqqPF q];
    
    if (~isempty(Robot.PF.xParticles))
        xxxPF = Robot.PF.xParticles;
    end
    
    vvv = [vvv Robot.MC.v];
    www = [www Robot.MC.w];
    
    if (Robot.SF.bestMtcIdx ~= 0)
        idx = Robot.SF.bestMtcIdx;
        x = Robot.Nodes(idx).x;
        y = Robot.Nodes(idx).y;
        fi = Robot.Nodes(idx).fi;
        q = [x y fi]'; % X Robot.Y Robot.Fi]';
        qqqSF = [qqqSF q]; 
    end
    
end

end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
function UpdateGrafic()

persistent cnt
if (isempty(cnt))
    cnt = 0;
end

cnt = cnt + 1;
if (mod(cnt,3) == 0)
    cnt = 0;
    UpdateGrafic_FigPolygon();   
    UpdateGrafic_FigRGB();
    drawnow;
end

end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
function InitGrafic()

InitGrafic_FigMap();
InitGrafic_FigRGB();

end







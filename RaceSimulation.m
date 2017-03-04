function RaceSimulation
close all, clear all 

cd(fileparts(mfilename('fullpath')))

addpath('Localization');
addpath('Motion');
addpath('PathPlanning');
addpath('Sensors');
addpath('PolygonMap');
addpath('Enviroment');
addpath('TrueWorld');
addpath('Plotting');

global Ts 
global TrueWalls TrueObstacleCenters TrueObstacles TrueKeepOut 
global PolygonMapColors BarvnaLestvicaRGB BarvnaLestvicaHSV BarvnaLestvicaRGB_pastel 
global DRAW_MORE
global user

user = 'matej';
% user = 'peter';

PolygonMapColors  = [];
BarvnaLestvicaRGB = [];
BarvnaLestvicaHSV = [];
BarvnaLestvicaRGB_pastel = [];

global TrueRobot Robot
global hhh
global qqqTrue qqq qP

global stanje stanjeend        % naèin delovanja
stanje = zeros(1);             % naèin delovanja
stanjeend = zeros(1);

load('PolygonMap/PolygonColorData.mat')
load('PathPlanning/Nodes.mat');

%% Init
Tend = 120;      % Simulation lasts 50s
Ts=0.033;       % sample time
ttt=0:Ts:Tend;    % time vector
% U=[];Tvzorcenja=[] ;Z=[];

qqqTrue = [];
qqq = [];
qP = [];

hhh = 0;

% DRAW_MORE = 1;
StartMode = 2;
if StartMode == 1
    InitGrafic();
end

load('TrueWalls.mat')
load('TrueObstaclesCenters.mat')

TrueWalls = InitTrueWalls();
TrueObstacleCenters = InitTrueObstacleCenters(StartMode);
TrueObstacles = ComputeObstacles(TrueObstacleCenters, 50);
TrueKeepOut = InitTrueKeepOut(TrueWalls, TrueObstacleCenters);

InitGrafic();

% TrueRobot = InitTrueRobot([190 530 3*pi/7]');
idx0 = 80;
x0 = Nodes(idx0).x + randi([-5 5]);
y0 = Nodes(idx0).y + randi([-5 5]);
fi0 = Nodes(idx0).fi + randi([-5 5])*pi/180;
TrueRobot = InitTrueRobot([x0 y0 fi0]');
% TrueRobot = InitTrueRobot([163 820 pi/2]');

% TrueRobot = InitTrueRobot([293 820 pi/4]');
%Robot = InitEV3([343 680 pi/2]');


% StoreData();
% UpdateGrafic();

%% Simulation

time_debug_stop = 15;

tic;
for i=1:length(ttt)
    
    if (i*Ts > time_debug_stop)
        time_debug_stop = time_debug_stop + 1;
    end
    
    SimulateEV3(i);
    
    v = Robot.v;
    w = Robot.w;
    SimulateTrueRobot(v,w);
    
    StoreData();
    UpdateGrafic();
    
%      pause(0.03);
%     if (ttt(i) > 30)
%       pause(0.03);
%     end   
end
duration = toc;
fprintf('Simulated %i sec, simulation finished in %i sec. /n', Tend, int32(duration));

% figure
% plot(qqTrue(:,1),qqTrue(:,2),qq(:,1),qq(:,2),'--')
% xlabel('x [m]'),ylabel('y [m]')
% figure
% plot(Tvzorcenja,U(:,1),Tvzorcenja,U(:,2),'--')
% xlabel('t [s]'),ylabel('v [m/s], \omega [rad/s]'),legend('v','\omega'),
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
global qqqTrue qqq qP

qqqTrue = [qqqTrue TrueRobot.q];
if (~isempty(Robot))
    q = [Robot.PF.q]; % X Robot.Y Robot.Fi]';
    qqq = [qqq q];
    
    if (~isempty(Robot.PF.xP))
        qP = Robot.PF.xP;
    end
end

end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function UpdateGrafic()
global TrueRobot Robot BarvnaLestvicaRGB
global qqqTrue qqq qP hhh 
DrawRobot(TrueRobot.q,1);        % drugi parameter: robot=1, odometrija=2
if (~isempty(Robot))
    DrawRobot(Robot.PF.q,2);            % drugi parameter: robot=1, odometrija=2

    set(hhh(3),'XData',qqqTrue(1,:),'YData',qqqTrue(2,:));      % izris prave poti
    set(hhh(4),'XData',qqq(1,:),'YData',qqq(2,:));              % izris ocenjene poti
    set(hhh(5),'XData',qP(1,:),'YData',qP(2,:));                % izris delcev
    set(hhh(8),'Color',  BarvnaLestvicaRGB(Robot.idxL,:)/255);
    set(hhh(9),'Color',  BarvnaLestvicaRGB(Robot.idxR,:)/255);
    set(hhh(10),'XData',Robot.posL(1),'YData',Robot.posL(2));   % izris pozicije LEVEGA rgb senzorja
    set(hhh(11),'XData',Robot.posR(1),'YData',Robot.posR(2));   % izris pozicije DESNEGA rgb senzorja
    
    if (~isempty(Robot.q_path))
        [x,y,u,v] = getQuiverOptimalPath(Robot.Path);
        set(hhh(12),'XData',x,'YData',y,'UData',u,'VData',v);   % naèrtovane poti
    end
    
end

drawnow;
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DrawRobot(Xr,tip)
global hhh

L_half = 90;
W_half = 60;
L_iner = 30;
W_iner = 30;
P=[L_iner L_half L_half -L_half -L_half -L_iner -L_iner -L_half -L_half  L_half  L_half  L_iner L_iner;...  % oblika robota
   W_iner W_iner W_half  W_half  W_iner  W_iner -W_iner -W_iner -W_half -W_half -W_iner -W_iner W_iner];

theta = Xr(3); 
Rkolo=[cos(theta) -sin(theta); sin(theta) cos(theta)];
T=repmat([Xr(1);Xr(2)],1,size(P,2)) ;

% toèke obrisa robota transliramo in rotiramo
P=Rkolo*P+T; 
set(hhh(tip),'XData',P(1,:),'YData',P(2,:))   % izris dejanskega robota
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function InitGrafic()
global PolygonMapColors BarvnaLestvicaRGB %BarvnaLestvicaRGB_pastel
global TrueWalls TrueObstacleCenters TrueObstacles TrueKeepOut
global hhh
global user
figure(10); clf; 
FigureSettings(10,user);
hold on;

% set(10, 'Position', [0 170 25*35 18*35]); %% matej
% set(10, 'Position', [-1600 20 25*60 18*60]);  %% pero
% set(10, 'Position', [750 100 25*30 18*30]); 

% Initialize data sets
hhh(1)= plot(0,0,'c','erasemode','xor','LineWidth',2) ;     % dejanski robot 
hhh(2)= plot(0,0,'m','erasemode','xor','LineWidth',2) ;     % robot z odometrijo 

hhh(3)= plot(0,0,'--c','erasemode','none') ;  % dejanska pot
hhh(4)= plot(0,0,'--m','erasemode','none') ;  % ocenjena pot z odometrijo oz. filtrom delcev
hhh(5)= plot(0,0,'.','Color','r','erasemode','xor', 'MarkerSize', 20) ;   % particle
hhh(6)= plot(nan,nan,'LineWidth',1,'Color','r') ;       % particle dir
hhh(7)= plot(nan,nan,'LineWidth',2,'Color','c') ;       % sensor

plot([2575,2675], [900,900], 'ko', 'MarkerSize', 21, 'LineWidth', 3);                   % round circles around sensors
hhh(8)= plot(2575, 900, 'k.','erasemode','xor','LineStyle', 'none', 'MarkerSize', 50);  % Levi RGB sensor
hhh(9)= plot(2675, 900, 'k.','erasemode','xor','LineStyle', 'none', 'MarkerSize', 50);  % Desni RGB sensor

hhh(10)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10); % Položaj Levega RGB senzorja
hhh(11)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10); % Položaj Desnega RGB senzorja

hhh(12)= quiver(0,0,0,0,'b','LineWidth',2,'AutoScale', 'Off'); % optimal path

% Draw polygon colors
ColorMap = BarvnaLestvicaRGB/255;
% DrawPolygonMapColors(10, PolygonMapColors, ColorMap);

% Draw Walls
DrawWalls(10, TrueWalls)

% Draw obstacles
DrawObstacles(10, TrueObstacleCenters);
DrawTrueObstacles(10, TrueObstacles, 'y--');

% Draw KeepOut
DrawKeepOut(10, TrueKeepOut, 'r--');

%hhh(6)=plot(0,0,'r','erasemode','xor')
legend('TrueRobot','EV3','path True','path EV3','particles')

hold off;
zoom on;

end


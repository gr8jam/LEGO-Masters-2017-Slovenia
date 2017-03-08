function RaceSimulation
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
global qqqTrue qqq qP vvv www ttt

global stanje stanjeend        % naèin delovanja
stanje = zeros(1);             % naèin delovanja
stanjeend = zeros(1);

load('PolygonMap/PolygonColorData.mat')
load('PathPlanning/Nodes.mat');

Robot.Nodes = Nodes;

%% Init
Tend = 60;      % Simulation lasts 50s
Ts=0.033;       % sample time
t=0:Ts:Tend;    % time vector
% U=[];Tvzorcenja=[] ;Z=[];

qqqTrue = [];
qqq = [];
qP = [];
vvv = [];
www = [];
ttt = [];

hhh = 0;

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

time_debug_stop = 3;

tic;
for i=1:length(t)
    
    if (i*Ts > time_debug_stop)
        time_debug_stop = time_debug_stop + 2;
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
plot(qqqTrue(1,:),qqqTrue(2,:),qqq(1,:),qqq(2,:),'--')
xlabel('x [mm]'),ylabel('y [mm]')

%% Draw speed and angular speed
figure
subplot(2,1,1)
plot(ttt,vvv,'-');
xlabel('t [s]'),ylabel('v [mm/s]');
subplot(2,1,2)
plot(ttt,www,'-');
xlabel('t [s]'),ylabel('omega [rad/s]');

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
global qqqTrue qqq qP vvv www

qqqTrue = [qqqTrue TrueRobot.q];
if (~isempty(Robot))
%     q = [Robot.PF.x Robot.PF.y Robot.PF.fi]'; % X Robot.Y Robot.Fi]';
%     qqq = [qqq q];
    
    if (~isempty(Robot.PF.xParticles))
        qP = Robot.PF.xParticles;
    end
    
    vvv = [vvv Robot.MC.v];
    www = [www Robot.MC.w];
    
    if (Robot.SF.bestMtcIdx ~= 0)
        idx = Robot.SF.bestMtcIdx;
        x = Robot.Nodes(idx).x;
        y = Robot.Nodes(idx).y;
        fi = Robot.Nodes(idx).fi;
        q = [x y fi]'; % X Robot.Y Robot.Fi]';
        qqq = [qqq q]; 
    end
    
end

end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function UpdateGrafic()
global TrueRobot Robot BarvnaLestvicaRGB
global qqqTrue qqq qP hhh hhL hhR hhS hhN hhB
DrawRobot(TrueRobot.q,1);        % drugi parameter: robot=1, odometrija=2
if (~isempty(Robot))
    DrawRobot([Robot.PF.x Robot.PF.y Robot.PF.fi]',2);            % drugi parameter: robot=1, odometrija=2

    set(hhh(3),'XData',qqqTrue(1,:),'YData',qqqTrue(2,:));      % izris prave poti
%     set(hhh(4),'XData',qqq(1,:),'YData',qqq(2,:));              % izris ocenjene poti
    set(hhh(5),'XData',qP(1,:),'YData',qP(2,:));                % izris delcev
    set(hhh(8),'Color',  BarvnaLestvicaRGB(Robot.SenRGB.Left.idx,:)/255);
    set(hhh(9),'Color',  BarvnaLestvicaRGB(Robot.SenRGB.Right.idx,:)/255);
    set(hhh(10),'XData',Robot.SenRGB.Left.x,'YData',Robot.SenRGB.Left.y);   % izris pozicije LEVEGA rgb senzorja
    set(hhh(11),'XData',Robot.SenRGB.Right.x,'YData',Robot.SenRGB.Right.y);   % izris pozicije DESNEGA rgb senzorja
    
    
    [x,y,u,v] = getQuiverOptimalPath();
    set(hhh(12),'XData',x,'YData',y,'UData',u,'VData',v);   % naèrtovane poti
    set(hhh(13),'XData',Robot.PP.xRef,'YData',Robot.PP.yRef);   % naèrtovane poti
    
    
    for i = -3:1:3
        for j = -3:1:3
            idx = Robot.SenRGB.Left.ColorArray(4-j,4-i);
            if (idx > 0)
                set(hhL(4-j,4-i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
            else
                set(hhL(4-j,4-i),'FaceColor','m');
            end
        end
    end
    
    for i = 1:7
        for j = 1:7
            idx = Robot.SenRGB.Right.ColorArray(j,i);
            if (idx > 0)
                set(hhR(j,i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
            else
                set(hhR(j,i),'FaceColor','m');
            end
        end
    end
    
    for i = 1:length(hhS)
        idx = Robot.SF.StackLastColors.buffer(i);
        if (idx > 0)
            set(hhS(i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
        else
            set(hhS(i),'FaceColor','m');
        end
    end
   
    for i = 1:96
        set(hhN(i),'MarkerSize', 5*Robot.Nodes(i).mtcColor + 1);
    end
    
    
    if (~isempty(qqq))
        idx = Robot.SF.bestMtcIdx;
        if (idx > 0)
            set(hhB,'XData',qqq(1,end),'YData',qqq(2,end),'MarkerSize', 10*Robot.Nodes(idx).mtcColor + 1);
        end
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
global PolygonMapColors BarvnaLestvicaRGB BarvnaLestvicaRGB_pastel
global TrueWalls TrueObstacleCenters TrueObstacles TrueKeepOut 
global hhh hhL hhR hhS hhN hhB
global user Robot

figure(9); clf;
screensize = get( groot, 'Screensize' );
W_screen = screensize(3);
H_screen = screensize(4);
W = W_screen/2;
H = 0.4 * W;
set(9, 'Position', [0 H_screen-H-100 W H]); %% matej
% set(9, 'Position', [W 0 W H]); %% matej


subplot(2,2,1);
title('Left RGB sensor ColorArray ')
hold on;
hhL = zeros(7,7);
for i = -3:1:3
    for j = -3:1:3
        hhL(4-j,4-i) = rectangle('Position',[i-0.5,j-0.5,1,1]);
    end
end
axis equal;

subplot(2,2,2);
title('Right RGB sensor ColorArray ')
hold on;
hhR = zeros(7,7);
for i = -3:1:3
    for j = -3:1:3
        hhR(4-j,4-i) = rectangle('Position',[i-0.5,j-0.5,1,1]);
    end
end
axis equal;

subplot(2,2,4);
title('StackLastColors ')
hold on;
hhS = zeros(5,1);
for i = 1:length(hhS)
    hhS(i) = rectangle('Position',[0,-i,1,1]);
end
axis([0 1 -5 0])






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



% Draw polygon colors
% ColorMap = BarvnaLestvicaRGB/255;
ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(10, PolygonMapColors, ColorMap);

% Draw Walls
DrawWalls(10, TrueWalls)

% Draw obstacles
DrawObstacles(10, TrueObstacleCenters);
DrawTrueObstacles(10, TrueObstacles, 'y--');

% Draw KeepOut
DrawKeepOut(10, TrueKeepOut, 'r--');

hhh(12)= quiver(0,0,0,0,'b','LineWidth',2,'AutoScale', 'Off'); % optimal path
hhh(13)= plot(0,0,'r.','MarkerSize',20,'erasemode','xor');  % goal node

hhN = zeros(96,1);
for i = 1:96
    hhN(i) = plot(Robot.Nodes(i).x, Robot.Nodes(i).y, 'ko', 'LineWidth', 3, 'MarkerSize', 1, 'erasemode','xor');
end

hhB = plot(0,0, 'm.', 'MarkerSize', 15, 'erasemode','xor');


%hhh(6)=plot(0,0,'r','erasemode','xor')
legend('TrueRobot','EV3','path True','path EV3','particles')

hold off;
zoom on;



end


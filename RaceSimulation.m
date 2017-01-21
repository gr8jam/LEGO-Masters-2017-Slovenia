function RaceSimulation
close all, clear all 

addpath('ParticleFilter');
addpath('LineFollower');
addpath('Nodes');
addpath('Sensors');
addpath('PolygonMap');
addpath('Obstacles');

global Ts Obstacles 
global PolygonMapColors BarvnaLestvicaRGB BarvnaLestvicaHSV BarvnaLestvicaRGB_pastel DRAW_MORE
PolygonMapColors  = [];
BarvnaLestvicaRGB = [];
BarvnaLestvicaHSV = [];
BarvnaLestvicaRGB_pastel = [];

global TrueRobot
global hhh
global qqqTrue qqq qP

global stanje stanjeend        % naèin delovanja
stanje = zeros(1);             % naèin delovanja
stanjeend = zeros(1);


load('PolygonMap/PolygonColorData.mat')
load('Nodes/Nodes.mat');

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
Obstacles = InitObstacles(StartMode);
InitGrafic();

% TrueRobot = InitTrueRobot([190 530 3*pi/7]');
idx0 = 80;
x0 = Nodes(idx0).x;
y0 = Nodes(idx0).y;
fi0 = Nodes(idx0).fi;
TrueRobot = InitTrueRobot([x0 y0 fi0]');
% TrueRobot = InitTrueRobot([163 820 pi/2]');

% TrueRobot = InitTrueRobot([293 820 pi/4]');
%Robot = InitEV3([343 680 pi/2]');


StoreData();
UpdateGrafic();

%% Simulation

tic;
for i=1:length(ttt)
    
%     if (2 < i ) && (i < 35)
%         pause(0.4 - i/100);
%     end
    [v,w] = SimulateEV3(TrueRobot.q,i);
    
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
    qqq = [qqq Robot.q];
    
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
    DrawRobot(Robot.q,2);            % drugi parameter: robot=1, odometrija=2

    set(hhh(3),'XData',qqqTrue(1,:),'YData',qqqTrue(2,:));      % izris prave poti
    set(hhh(4),'XData',qqq(1,:),'YData',qqq(2,:));              % izris ocenjene poti
    set(hhh(5),'XData',qP(1,:),'YData',qP(2,:));                % izris delcev
    set(hhh(8),'Color',  BarvnaLestvicaRGB(Robot.idxL,:)/255);
    set(hhh(9),'Color',  BarvnaLestvicaRGB(Robot.idxR,:)/255);
    set(hhh(10),'XData',Robot.posL(1),'YData',Robot.posL(2));   % izris pozicije LEVEGA rgb senzorja
    set(hhh(11),'XData',Robot.posR(1),'YData',Robot.posR(2));   % izris pozicije DESNEGA rgb senzorja
    
%     if(DRAW_MORE)
%       set(hhh(7), ...   % sensor
%             'XData', reshape([TrueRobot.q(1)*ones(1,1); TrueRobot.q(1)*ones(1,1)+Robot.dist.*cos(TrueRobot.q(3)); nan(1,1)], 1, []), ...
%             'YData', reshape([TrueRobot.q(2)*ones(1,1); TrueRobot.q(2)*ones(1,1)+Robot.dist.*sin(TrueRobot.q(3)); nan(1,1)], 1, []), ...
%             'ZData', reshape([10+0.1*ones(1, 1); 10+0.1*ones(1, 1); 10+0.1*ones(1, 1)], 1, []));
%      end
%     Robot.dist
end

drawnow;
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DrawRobot(Xr,tip)
global hhh

P=[1 4 4 -4 -4 -1 -1 -4 -4 4 4 1 1;...  % oblika robota
   3 3 4 4 3 3 -3 -3 -4 -4 -3 -3 3]*20;         

theta = Xr(3); 
Rkolo=[cos(theta) -sin(theta); sin(theta) cos(theta)];
T=repmat([Xr(1);Xr(2)],1,size(P,2)) ;

% toèke obrisa robota transliramo in rotiramo
P=Rkolo*P+T; 
set(hhh(tip),'XData',P(1,:),'YData',P(2,:))   % izris dejanskega robota
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function InitGrafic()
global BarvnaLestvicaRGB %BarvnaLestvicaRGB_pastel
global hhh
figure(10); clf; 
set(10, 'Position', [1600 -150 25*60 18*60]); %% matej
% set(10, 'Position', [-1600 20 25*60 18*60]);  %% pero
% set(10, 'Position', [750 100 25*30 18*30]); 
hold on;

% Apperance setings
zoom on;
title('Localization of diferential drive robot');xlabel('x (mm)');ylabel('y (mm)');
axis equal
axis([-5,2805,-5,1805]); 

% Initialize data sets

hhh(1)= plot(0,0,'c','erasemode','xor','LineWidth',2) ;     % dejanski robot 
hhh(2)= plot(0,0,'m','erasemode','xor','LineWidth',2) ;     % robot z odometrijo 

hhh(3)= plot(0,0,'--b','erasemode','none') ;  % dejanska pot
hhh(4)= plot(0,0,'--g','erasemode','none') ;  % ocenjena pot z odometrijo oz. filtrom delcev
hhh(5)= plot(0,0,'.','Color','r','erasemode','xor', 'MarkerSize', 20) ;   % particle
hhh(6)= plot(nan,nan,'LineWidth',1,'Color','r') ;       % particle dir
hhh(7)= plot(nan,nan,'LineWidth',2,'Color','c') ;       % sensor

plot([2575,2675], [900,900], 'ko', 'MarkerSize', 21, 'LineWidth', 3);
hhh(8)= plot(2575, 900, 'k.','erasemode','xor','LineStyle', 'none', 'MarkerSize', 50);  % Levi RGB sensor
hhh(9)= plot(2675, 900, 'k.','erasemode','xor','LineStyle', 'none', 'MarkerSize', 50);  % Desni RGB sensor

hhh(10)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10); % Položaj Levega RGB senzorja
hhh(11)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10); % Položaj Desnega RGB senzorja

% Draw polygon colors
colorMap = BarvnaLestvicaRGB/255;
DrawPolygonMapColors(10,colorMap);

% Draw obstacles
DrawObstacles(10);

% hhh(10)= plot(2650, 900, 'k.', 'LineStyle', 'none', 'MarkerSize', 50);
% hhh(11)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10);
% hhh(12)= plot(2550, 900, 'k.', 'LineStyle', 'none', 'MarkerSize', 50);
% hhh(13)= plot(2700, 900, 'k.', 'LineStyle', 'none', 'MarkerSize', 50);

%hhh(6)=plot(0,0,'r','erasemode','xor')
legend('TrueRobot','EV3','path','path EV3','particles')

hold off;

end


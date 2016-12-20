function RobotSimulation

close all, clear all 

global Ts Obstacles
global TrueRobot Robot
global hhh
global qqqTrue qqq qP

global stanje stanjeend                                                     % naèin delovanja
stanje = zeros(1);                                                          % naèin delovanja
stanjeend = zeros(1);



%% Init
Ts=0.033; % sample time
ttt=0:Ts:50; % time vector
% U=[];Tvzorcenja=[] ;Z=[];

qqqTrue = [];
qqq = [];
qP = [];

hhh = 0;
InitGrafic();
TrueRobot = InitTrueRobot([305 680 pi/2]');
Robot = InitEV3([343 680 pi/2]');
Obstacles = InitObstacles();

StoreData();
UpdateGrafic();

%% Simulation

for i=1:length(ttt)
    
    [v,w] = SimulateEV3(TrueRobot.q);
    
    SimulateTrueRobot(v,w);
    
    StoreData();
    UpdateGrafic();
    
    %pause(0.01);
    
end

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% FUNKCIJE    %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function StoreData
global TrueRobot Robot
global qqqTrue qqq qP

qqqTrue = [qqqTrue TrueRobot.q];
qqq = [qqq Robot.q];
qP = Robot.xP;

end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function UpdateGrafic()
global TrueRobot Robot
global qqqTrue qqq qP hhh
DrawRobot(TrueRobot.q,1);        % drugi parameter: robot=1, odometrija=2
DrawRobot(Robot.q,2);            % drugi parameter: robot=1, odometrija=2
set(hhh(3),'XData',qqqTrue(1,:),'YData',qqqTrue(2,:));     % izris prave poti
set(hhh(4),'XData',qqq(1,:),'YData',qqq(2,:));             % izris ocenjene poti

LeOdometrija = 0;
if( ~LeOdometrija)
    set(hhh(5),'XData',qP(1,:),'YData',qP(2,:));  % izris delcev
%     rr=.15;       
%     if(DRAW_MORE)
%        set(hhh(6), ...   % particle dir
%             'XData', reshape([xP(1,:); xP(1,:)+rr*cos(xP(3,:)); nan(1,nParticles)], 1, []), ...
%             'YData', reshape([xP(2,:); xP(2,:)+rr*sin(xP(3,:)); nan(1,nParticles)], 1, []), ...
%             'ZData', reshape([10+0.1*ones(1, nParticles); 10+0.1*ones(1, nParticles); 10+0.1*ones(1, nParticles)], 1, []));
%     end
end

% if(DRAW_MORE)
% set(hhh(7), ...   % sensor
%     'XData', reshape([qTrue(1)*ones(1,3); qTrue(1)*ones(1,3)+zTrue'.*cos(qTrue(3)+[-2*pi/3,0,2*pi/3]); nan(1,3)], 1, []), ...
%     'YData', reshape([qTrue(2)*ones(1,3); qTrue(2)*ones(1,3)+zTrue'.*sin(qTrue(3)+[-2*pi/3,0,2*pi/3]); nan(1,3)], 1, []), ...
%     'ZData', reshape([10+0.1*ones(1, 3); 10+0.1*ones(1, 3); 10+0.1*ones(1, 3)], 1, []));
% end

drawnow;
end



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Obstacles = InitObstacles()
% osnovni element je daljica podana z daljico: x1 y1 x2 y2
Obstacles=[  0 0 2500 0;...         % spodnji rob
             0 0 0 1800;...         % levi rob
             0 1800 2500 1800;...   % zgornji rob
             2500 0 2500 1800;....  % desni rob
             1349 0 1349 275;...                    % spodnja ovira
             2500-1349 1800 2500-1349 1800-275;...  % zgornja ovira
             625 610 625 610+580;...                % leva ovira
             625+1250 610 625+1250 610+580;...      % desna ovira
             625 1800/2 625+1250 1800/2  ];         % sredinska ovira

   for i=1:size(Obstacles,1)
       line(Obstacles(i,[1,3]),Obstacles(i,[2,4]),'LineWidth',3,'Color','m'); 
   end
end




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DrawRobot(Xr,tip);
global hhh

P=[1 4 4 -4 -4 -1 -1 -4 -4 4 4 1 1;...  % oblika robota
   3 3 4 4 3 3 -3 -3 -4 -4 -3 -3 3]*15;         

theta = Xr(3); 
Rkolo=[cos(theta) -sin(theta); sin(theta) cos(theta)];
T=repmat([Xr(1);Xr(2)],1,size(P,2)) ;

% toèke obrisa robota transliramo in rotiramo
P=Rkolo*P+T; 
set(hhh(tip),'XData',P(1,:),'YData',P(2,:))   % izris dejanskega robota
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function InitGrafic()

global hhh
figure(10); clf; 
% set(10, 'Position', [-1900 -100 25*50 18*50]); 
% set(10, 'Position', [-750 -200 25*30 18*30]); 
set(10, 'Position', [750 100 25*30 18*30]); 
hold on;

% Draw polygon colors
load('Polygon_map');                % load polygon_map
% colorMap = colorMap_Original;     % Choose colorMap
colorMap = colorMap_Pastel;         

for i = 1:length(colorMap)          % draw each color
    bool = (colors == i-1);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', colorMap(i,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);
end

% Apperance setings
zoom on;
title('Localization of diferential drive robot');xlabel('x (m)');ylabel('y (m)');
axis equal
axis([-5,2805,-5,1805]); 

% Initialize data sets
hhh(1)= plot(0,0,'b','erasemode','xor','LineWidth',2) ;     % dejanski robot 
hhh(2)= plot(0,0,'g','erasemode','xor','LineWidth',2) ;     % robot z odometrijo 

hhh(3)= plot(0,0,'--b','erasemode','none') ;  % dejanska pot
hhh(4)= plot(0,0,'--g','erasemode','none') ;  % ocenjena pot z odometrijo oz. filtrom delcev
hhh(5)= plot(0,0,'.','Color','r','erasemode','xor') ;   % particle
hhh(6)= plot(nan,nan,'LineWidth',1,'Color','r') ; % particle dir
hhh(7)= plot(nan,nan,'LineWidth',2,'Color','c') ; % sensor
hhh(8)= plot(2600, 900, 'k.',  'LineStyle', 'none', 'MarkerSize', 50);  %'erasemode','xor',
hhh(9)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10);
hhh(10)= plot(2650, 900, 'k.', 'LineStyle', 'none', 'MarkerSize', 50);
hhh(11)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10);
hhh(12)= plot(2550, 900, 'k.', 'LineStyle', 'none', 'MarkerSize', 50);
hhh(13)= plot(2700, 900, 'k.', 'LineStyle', 'none', 'MarkerSize', 50);

%hhh(6)=plot(0,0,'r','erasemode','xor')
%legend('rob','robOdo','pot','odo.','ref.','okolje')
%legend('rob.','pot','ref.')
legend('rob','robEst','path','pathEst','particles')

hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function TrueRobot = InitTrueRobot(q0)
TrueRobot = struct('R', 0.05,...
                   'L', 0.15,...
                   'q', q0);       
end
               
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%               
function SimulateTrueRobot(v,w)
  global Ts TrueRobot
  flag_sum = 1; % stikalo za vkolop ali izkolp šuma
  
  %nimamo toènega podatka o dimenzijah robota Rkolo in Lrob, ki so v resnici
  Rt=TrueRobot.R;
  Lt=TrueRobot.L;
  % dodatno se dejansko kolo zaradi majnih zdrsov, neravnin, itd... vrti z
  % nekim dodanim šumom
  SIGMA_W=0.3;
  % kotne hitrosti koles glede na vhode z dodanim šumom
  wR=1/(TrueRobot.R)*(v+w*(TrueRobot.L)/2)+SIGMA_W*randn(1,1)*flag_sum;
  wL=1/(TrueRobot.R)*(v-w*(TrueRobot.L)/2)+SIGMA_W*randn(1,1)*flag_sum;
  
  % dejanska hitrost robota je torej
    vt=Rt/2*(wR+wL);
    wt=Rt/Lt*(wR-wL);
   
 	TrueRobot.q(1)= TrueRobot.q(1) + Ts*vt*cos( TrueRobot.q(3) + Ts*wt/2 );
	TrueRobot.q(2)= TrueRobot.q(2) + Ts*vt*sin( TrueRobot.q(3) + Ts*wt/2 );
    TrueRobot.q(3)= TrueRobot.q(3) + Ts*wt;
    
    TrueRobot.q(3)=wrapToPi(TrueRobot.q(3));    % popravi kot q(3)  
    
end












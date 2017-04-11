function InitGrafic_FigMap()
global PolygonMapColors BarvnaLestvicaRGB BarvnaLestvicaRGB_pastel
global TrueWalls TrueObstacleCenters TrueObstacles TrueKeepOut 
global hFigMap hhN hhB
global user Nodes

FigPolygon = figure(); 
clf; 
FigureSettings_FigPolygon(FigPolygon,user);
hold on;

%% Draw enviroment
% Draw polygon colors
% ColorMap = BarvnaLestvicaRGB/255;
ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(FigPolygon, PolygonMapColors, ColorMap);

% Draw Walls
DrawWalls(FigPolygon, TrueWalls)

% Draw obstacles
DrawObstacles(FigPolygon, TrueObstacleCenters);
DrawTrueObstacles(FigPolygon, TrueObstacles, 'y--');

% Draw KeepOut
DrawKeepOut(FigPolygon, TrueKeepOut, 'r--');

%% Initialize data sets
hFigMap.probSF = zeros(96,1);
for i = 1:96
%     hhN(i) = plot(Robot.Nodes(i).x, Robot.Nodes(i).y, 'ko', 'LineWidth', 3, 'MarkerSize', 1, 'erasemode','xor');
    hFigMap.probSF(i) = plot(Nodes(i).x, Nodes(i).y, 'ko', 'LineWidth', 3, 'MarkerSize', 1);
end

hFigMap.pathOpt = quiver(0,0,0,0,'b','LineWidth',2,'AutoScale','Off'); % optimal path
hFigMap.pathGoal = plot(0,0,'r.','MarkerSize',20);                  % Next target

hFigMap.pathTrue = line(nan,nan,'Color','c','LineStyle', '--') ;    % True robot path
hFigMap.pathPF   = line(nan,nan,'Color','m','LineStyle', '--') ;    % Estimated robot path (PF)

hFigMap.robotTrue = line(nan,nan,'Color','c','LineWidth',2) ;       % True robot 
hFigMap.robotPF   = line(nan,nan,'Color','m','LineWidth',2) ;       % Robot Estimation PF

plot([1175,1325], [-90,-90],'ko','MarkerSize',17,'LineWidth',2);    % Color sensors readings
hFigMap.SenLCol = plot(1175,-90,'k.','MarkerSize',45);              % Left  color sensor reading
hFigMap.SenRCol = plot(1325,-90,'k.','MarkerSize',45);              % Right color sensor reading
hFigMap.SenLPos = plot(nan,nan,'c+','MarkerSize', 10);              % Left  color sensor position
hFigMap.SenRPos = plot(nan,nan,'c+','MarkerSize', 10);              % Right color sensor position

hFigMap.xxxPF = plot(nan,nan,'.','Color','r', 'MarkerSize', 5);     % Particles

% hhB = plot(0,0, 'm.', 'MarkerSize', 15, 'erasemode','xor');
% hhB = plot(0,0, 'm.', 'MarkerSize', 15);

hFigMap.sen1  = plot(nan,nan,'LineWidth',1,'Color','r') ;           % unused
hFigMap.sen2  = plot(nan,nan,'LineWidth',2,'Color','c') ;           % unused


%hFigMap(6)=plot(0,0,'r','erasemode','xor')
% legend('TrueRobot','EV3','path True','path EV3','particles')
% set(gca,'LegendColorbarListeners',[]); 
% setappdata(gca,'LegendColorbarManualSpace',1);
% setappdata(gca,'LegendColorbarReclaimSpace',1);

hold off;
% zoom on;



end


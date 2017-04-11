function InitGrafic_FigMap()
global PolygonMapColors BarvnaLestvicaRGB BarvnaLestvicaRGB_pastel
global TrueWalls TrueObstacleCenters TrueObstacles TrueKeepOut 
global hFigMap hhN hhB
global user Nodes

FigPolygon = figure(); 
clf; 
FigureSettings_FigPolygon(FigPolygon,user);
hold on;

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

% Initialize data sets
% hFigMap(1)= plot(0,0,'c','erasemode','xor','LineWidth',2) ;     % dejanski robot 
% hFigMap(2)= plot(0,0,'m','erasemode','xor','LineWidth',2) ;     % robot z odometrijo 
hFigMap(1)= line(nan,nan,'Color','c','LineWidth',2) ;     % dejanski robot 
hFigMap(2)= line(nan,nan,'Color','m','LineWidth',2) ;     % robot z odometrijo 


% hFigMap(3)= plot(0,0,'--c','erasemode','none') ;  % dejanska pot
% hFigMap(4)= plot(0,0,'--m','erasemode','none') ;  % ocenjena pot z odometrijo oz. filtrom delcev
% hFigMap(5)= plot(0,0,'.','Color','r','erasemode','xor', 'MarkerSize', 20) ;   % particle
hFigMap(3)= line(nan,nan,'Color','c','LineStyle', '--') ;  % dejanska pot
hFigMap(4)= line(nan,nan,'Color','m','LineStyle', '--') ;  % ocenjena pot z odometrijo oz. filtrom delcev

hFigMap(5)= plot(nan,nan,'.','Color','r', 'MarkerSize', 5) ;   % particle
hFigMap(6)= plot(nan,nan,'LineWidth',1,'Color','r') ;       % particle dir
hFigMap(7)= plot(nan,nan,'LineWidth',2,'Color','c') ;       % sensor

plot([2575,2675], [900,900], 'ko', 'MarkerSize', 19, 'LineWidth', 3);                   % round circles around sensors
% hFigMap(8)= plot(2575, 900, 'k.','erasemode','xor','LineStyle', 'none', 'MarkerSize', 50);  % Levi RGB sensor
% hFigMap(9)= plot(2675, 900, 'k.','erasemode','xor','LineStyle', 'none', 'MarkerSize', 50);  % Desni RGB sensor
hFigMap(8)= plot(2575, 900, 'k.','LineStyle', 'none', 'MarkerSize', 45);  % Levi RGB sensor
hFigMap(9)= plot(2675, 900, 'k.','LineStyle', 'none', 'MarkerSize', 45);  % Desni RGB sensor


% hFigMap(10)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10); % Položaj Levega RGB senzorja
% hFigMap(11)= plot(0,0,'c+','erasemode','xor','MarkerSize', 10); % Položaj Desnega RGB senzorja
hFigMap(10)= plot(nan,nan,'c+','MarkerSize', 10); % Položaj Levega RGB senzorja
hFigMap(11)= plot(nan,nan,'c+','MarkerSize', 10); % Položaj Desnega RGB senzorja

hFigMap(12)= quiver(0,0,0,0,'b','LineWidth',2,'AutoScale', 'Off'); % optimal path
% hFigMap(13)= plot(0,0,'r.','MarkerSize',20,'erasemode','xor');  % goal node
hFigMap(13)= plot(0,0,'r.','MarkerSize',20);  % goal node


hhN = zeros(96,1);
for i = 1:96
%     hhN(i) = plot(Robot.Nodes(i).x, Robot.Nodes(i).y, 'ko', 'LineWidth', 3, 'MarkerSize', 1, 'erasemode','xor');
    hhN(i) = plot(Nodes(i).x, Nodes(i).y, 'ko', 'LineWidth', 3, 'MarkerSize', 1);
end

% hhB = plot(0,0, 'm.', 'MarkerSize', 15, 'erasemode','xor');
hhB = plot(0,0, 'm.', 'MarkerSize', 15);


%hFigMap(6)=plot(0,0,'r','erasemode','xor')
% legend('TrueRobot','EV3','path True','path EV3','particles')
% set(gca,'LegendColorbarListeners',[]); 
% setappdata(gca,'LegendColorbarManualSpace',1);
% setappdata(gca,'LegendColorbarReclaimSpace',1);

hold off;
% zoom on;



end


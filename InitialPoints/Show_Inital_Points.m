close all;
clear all;

load('PolygonColorData.mat')

fig = figure;
set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on;

% Draw polygon colors
colorMap = BarvnaLestvicaRGB/255;
xS = 1;
xF = 2500;
yS = 1;
yF = 1800;

xGrid = repmat(xS:xF,yF-yS+1,1);
yGrid = repmat(yS:yF,xF-xS+1,1)';

for idx = 1:length(BarvnaLestvicaRGB)
    bool = (PolygonMapColors(yS:yF,xS:xF) == idx);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', colorMap(idx,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);
end


%% Compte Star Pose
% StartPose = struct('x',0,...
%                    'y',0,...
%                    'fi',0);
% 
%                
% StartPos = [];
% load('StartPos');
% 
% StartPose = [];
% for i = 1:length(StartPos)
%     x = StartPos(i).x;
%     y = StartPos(i).y;
%     fi = getInitialPointsAngle(x, y);
%     
%     StartPose1.x = x;
%     StartPose1.y = y;
%     StartPose1.fi = fi;
%     
%     StartPose = [StartPose StartPose1];
%     r = 100;
%     
% %     plot(x,y,'m+','LineWidth',2, 'MarkerSize', 15);
% %     plot([x; x+r*cos(fi)], [y; y+r*sin(fi)], 'm-','LineWidth',2)
%     
%     quiver(x,y,r*cos(fi),r*sin(fi),'m','LineWidth',2)
% end
% 
% 
% save('StartPose.mat', 'StartPose');


%% Show Start Pose
clear all;
load('StartPose');

for i = 1:length(StartPose)
    x = StartPose(i).x;
    y = StartPose(i).y;
    fi = StartPose(i).fi;
    
    r = 100;
    quiver(x,y,r*cos(fi),r*sin(fi),'m','LineWidth',2)
end















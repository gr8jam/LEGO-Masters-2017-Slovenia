close all;
clear all;

global Nodes d_max_tr_1 d_max_tr_2 d_max_tr_3
d_max_tr_1 = 0;
d_max_tr_2 = 0;
d_max_tr_3 = 0;
Nodes = [];

load('Nodes');

fig = figure;
set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on;

% Draw polygon colors
load('../PolygonColorData.mat')
colorMap = BarvnaLestvicaRGB/255;
xS = 1;
xF = 2500;
yS = 1;
yF = 1800;

xGrid = repmat(xS:xF,yF-yS+1,1);
yGrid = repmat(yS:yF,xF-xS+1,1)';

[m,n] = size(BarvnaLestvicaRGB);
idx = 17; % draw only black
bool = (PolygonMapColors(yS:yF,xS:xF) == idx);
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorMap(idx,:)+0.8, 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);


for i = 1:length(Nodes)
    plot(Nodes(i).x,Nodes(i).y,'r.','MarkerSize',20)
end

ShowNodesConnections();













function Select_Initial_Points()
close all;
clear all;

global StartPos hhh
StartPos = [];

load('StartPos');

fig = figure;
% set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej


hold on;

load('PolygonColorData.mat')

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


hhh(1) = plot(xS,yS,'m+','erasemode','none','LineWidth',2, 'MarkerSize', 15) ; 

for i=1:length(StartPos)
    set(hhh(1),'XData',StartPos(i).x,'YData',StartPos(i).y);
    drawnow;
end
drawnow;

pogoj = true;
while pogoj
    [x,y] = ginput(1);
    x = int32(x);
    y = int32(y);
    
    if (x > xF) || (x < xS) || (y<yS) || (y > yF)
%         pogoj = false;
        break;
    end
    
    point = struct('x', x,...
                   'y', y);

    if isempty(StartPos)
        StartPos = point;
    else
        flag_add = true;
        for i=1:length(StartPos)
            if ((abs(x-points(i).x) < 20) && (abs(y-points(i).y) < 20) )
               StartPos(i) = point;
               flag_add = false;
               break;
            end
        end
        if flag_add
            StartPos = [StartPos point];
        end 
    end

    for i=1:length(StartPos)
        set(hhh(1),'XData',StartPos(i).x,'YData',StartPos(i).y); 
    end
    
    if (x > xF) || (x < xS) || (y<yS) || (y > yF)
        pogoj = false;
    end
end


for i=1:length(StartPos)
    set(hhh(1),'XData',StartPos(i).x,'YData',StartPos(i).y); 
    drawnow;
end
    

%%
% points = [];
save('StartPos.mat', 'StartPos');

StartPos
end

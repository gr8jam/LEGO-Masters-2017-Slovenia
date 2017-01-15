close all;
clear all;

load('Nodes');

fig = figure;
set(fig, 'Position', [-1600 -150 25*60 18*60]); %% matej
hold on;

% Draw polygon colors
load('PolygonColorData.mat')
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

% hj = plot(1250,900,'r.','MarkerSize',20,'erasemode','xor');
hi = plot(1250,900,'g.','MarkerSize',20,'erasemode','xor');
hd = plot(1250,900,'b-','LineWidth',1,'erasemode','xor');
for j = 1:length(Nodes(i).Neighbours)
    hj(j) = plot([0 0],[0 1],'b-','LineWidth',2,'erasemode','xor');
%     hj(j) = quiver(0,0,0,0,'b-','LineWidth',2,'erasemode','xor');
end
    
i = 1;
for n = 1:length(Nodes)
    
    %% Draw current Node
    xi = Nodes(i).x;
    yi = Nodes(i).y;
    set(hi,'XData',xi,'YData',yi);
    
    %% Draw area circle around current Node
    switch floor((i-1)/32) + 1 
        case 1
            d_max = 290;
        case 2
            d_max = 330;
        case 3
            d_max = 380;
        otherwise
            d_max = 10;
    end
    ang = Nodes(i).fi-pi/2-pi/36 : 0.01 : Nodes(i).fi+pi/2+pi/36;
    xd = d_max*cos(ang) + xi;
    yd = d_max*sin(ang) + yi;
    set(hd,'XData',[xi xd xi],'YData',[yi yd yi]);
    drawnow;
    
    %% Draw connection to current Node's Neighbours
    for j = 1:length(Nodes(i).Neighbours)
        set(hj(j),'XData',[0 0],'YData',[0 0]);
        drawnow;
    end
        
    for j = 1:length(Nodes(i).Neighbours)
        idxj = Nodes(i).Neighbours(j).idx;
        if (idxj == 0)
            break;
        else
            xj = Nodes(idxj).x;
            yj = Nodes(idxj).y;
            fi_arrow = atan2(yi-yj,xi-xj);
            d_arrow = 25;
            xarrow = xj + [d_arrow*cos(fi_arrow-pi/6);
                           0;
                           d_arrow*cos(fi_arrow+pi/6)]';
            yarrow = yj + [d_arrow*sin(fi_arrow-pi/6);
                           0;
                           d_arrow*sin(fi_arrow+pi/6)]';
            
%             hj(j) = plot([xi xj],[yi yj],'b-','LineWidth',2,'erasemode','xor');    
            set(hj(j),'XData',[xi xj xarrow],'YData',[yi yj yarrow]);
            drawnow;
        end
        pause(0.2);
    end
    
    selectedPts = mouseinput_timeout(1, gca);
    
    i = i + 1;
    
    if ~isempty(selectedPts)
        [xClick,yClick] = ginput(1);
        for k = 1:length(Nodes)
            xk = Nodes(k).x;
            yk = Nodes(k).y;
            
            if (abs(xClick-xk) < 30) && (abs(yClick-yk) < 30)
                i = k;
                break;
            end
        end
    end
    
end









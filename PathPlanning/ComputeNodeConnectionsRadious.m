close all;
clear all;

cd(fileparts(mfilename('fullpath')))

addpath('..\PolygonMap')
addpath('..\Sensors')
addpath('..\Enviroment')
addpath('..\TrueWorld')
addpath('..\Plotting')

Nodes = [];
PolygonMapColors = [];
Walls = [];
WallsKeepOut = [];

load('Nodes');
load('PolygonColorData.mat');
load('Walls');
load('WallsKeepOut');

d_max_tr_1 = 290;
d_max_tr_2 = 330;
d_max_tr_3 = 380;

fig = figure;
FigureSettings(fig,'matej');
hold on;


%% Draw Polygon
ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,PolygonMapColors,ColorMap)

%% Draw Nodes
ColorMap = BarvnaLestvicaRGB_pastel;
DrawNodesPositions(fig,Nodes,ColorMap,0);

%% Init plot handels
hj = plot(1250,900,'b.','MarkerSize',20,'erasemode','xor');
hi = plot(1250,900,'g.','MarkerSize',20,'erasemode','xor');
hd = plot(1250,900,'b-','MarkerSize',2,'erasemode','xor');

%% Loop trough all Nodes
for i = 1:length(Nodes)
    %% Current node data
    xi = Nodes(i).x;
    yi = Nodes(i).y;
    fi = Nodes(i).fi;
    set(hi,'XData',xi,'YData',yi);
    
    
    %% Area around current node
    switch floor((i-1)/32) + 1 
        case 1
            d_max = d_max_tr_1;
        case 2
            d_max = d_max_tr_2;
        case 3
            d_max = d_max_tr_3;
        otherwise
            d_max = 10;
    end
    
    ang = fi-pi/2-pi/36 : 0.01 : fi+pi/2+pi/36;
    xd = d_max*cos(ang) + xi;
    yd = d_max*sin(ang) + yi;
    set(hd,'XData',[xi xd xi],'YData',[yi yd yi]);
    drawnow;
    
    %% Debug tool
    if i == 8
        a = 48;
    end
    
    %% Init Connections
    Nodes(i).ConnIndex = zeros(1,10);
    Nodes(i).ConnWeight = ones(1,10) * 99999;
    Nodes(i).ConnCount = 0;
    
    %% Loop trough nodes and connect neighbours in the area
    for j = 1:length(Nodes)
        %% Check if neighbour is on the right track
        switch floor((i-1)/32) + 1 
            case 1
                d_max = d_max_tr_1;
                if (65 <= j) && (j <=96)
                    continue;
                end
            case 2
                d_max = d_max_tr_2;
            case 3
                d_max = d_max_tr_3;
                if (1 <= j) && (j <=32)
                    continue;
                end
            otherwise
                d_max = 10;
        end
        
        %%        
        if (i ~= j)
            %% Show j-th node
            set(hj,'XData',Nodes(j).x,'YData',Nodes(j).y);
            %% Check if inside correct angle
            alfa = atan2(Nodes(j).y - Nodes(i).y, Nodes(j).x - Nodes(i).x);
            beta = Nodes(i).fi - alfa;
            beta = wrapToPi(beta);
            ang_limit = pi/2+pi/36;
            gama = beta * 180 / pi;
            if (-ang_limit <= beta && beta <= ang_limit)
                %% Check if inside correct distance
                d = sqrt((Nodes(i).x-Nodes(j).x)^2 + ...
                         (Nodes(i).y-Nodes(j).y)^2 );
                d = round(d);
                if (d < d_max)
                    Nodes(i).ConnCount = Nodes(i).ConnCount + 1;
                    Nodes(i).ConnIndex(Nodes(i).ConnCount) = j;
                    Nodes(i).ConnWeight(Nodes(i).ConnCount) = d;
                end
            end
        end
            
    end
    if Nodes(i).ConnCount >= 10
        error('To many connections for node %d within the area! \n', i);
    end
    [Nodes(i).ConnWeight, sortIdx] = sort(Nodes(i).ConnWeight);
    Nodes(i).ConnIndex = Nodes(i).ConnIndex(sortIdx);
    
    pause(0.1);

end

%%
% save('Nodes','Nodes','d_max_tr_1','d_max_tr_2','d_max_tr_3');

clear all
load('Nodes')





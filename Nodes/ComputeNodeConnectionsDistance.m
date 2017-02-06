close all;
clear all;

global Nodes Obstacles PolygonMapColors
Nodes = [];
BarvnaLestvicaRGB_pastel = [];
PolygonMapColors = [];

% d_max_tr_1 = 290;
% d_max_tr_2 = 330;
% d_max_tr_3 = 380;

addpath('..\PolygonMap')
addpath('..\Sensors')
addpath('..\Obstacles')

load('Nodes');
load('PolygonColorData.mat');

Walls = InitWalls();
Obstacles = InitObstacles(2);
KeepOut = InitKeepOut(Walls, Obstacles);

fig = figure;
set(fig, 'Position', [0 170 25*35 18*35]); %% matej
hold on;

ColorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,PolygonMapColors,ColorMap);
DrawNodesPositions(fig,Nodes,0);
DrawObstacles(fig, Obstacles);
DrawKeepOut(fig, KeepOut);

%% Init plot handels
hj = plot(1250,900,'b.','MarkerSize',20,'erasemode','xor');
hi = plot(1250,900,'g.','MarkerSize',20,'erasemode','xor');
hd = plot(1250,900,'b-','MarkerSize',2);
hn = plot(1250,900,'b-','LineWidth',3);
ho = plot(1250,900,'r-','LineWidth',3);
hr = plot(1250,900,'b-','LineWidth',2);

%% Loop trough all Nodes
for i = 1:length(Nodes)
    %% Current node data
    xi = Nodes(i).x;
    yi = Nodes(i).y;
    fi = Nodes(i).fi;
    set(hi,'XData',xi,'YData',yi);
    
    
    %% Area around current node  
    r_max = 900;
    d_max = linspace(0,r_max,200);  %
    
    ang = [fi-pi/2-pi/36, fi+pi/2+pi/36];
    xdd = d_max'*cos(ang) + xi;
    ydd = d_max'*sin(ang) + yi;
    
    bool = (0<=xdd)&(xdd<=2500)&(0<=ydd)&(ydd<=1800);
    xd = xdd(bool);
    yd = ydd(bool);
    
    set(hd,'XData',xd,'YData',yd);
    
    %% Debug tool
    if i == 8
        a = 48;
    end
    
    %% Init Connections
    Nodes(i).ConnIndex = zeros(1,100);
    Nodes(i).ConnWeight = ones(1,100) * 99999;
    Nodes(i).ConnCount = 0;
    
    %% Loop trough nodes and connect neighbours in the area
    for j = 1:length(Nodes)      
        %%      
        set(hn,'XData',[],'YData',[]);
        set(ho,'XData',[],'YData',[]);
        
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
                %% Check if no 
                xj = Nodes(j).x;
                yj = Nodes(j).y;
                fij = Nodes(j).fi;
                fi_to_node = atan2(yj-yi, xj-xi);
                
                d_to_node = sqrt((Nodes(i).x-Nodes(j).x)^2 + ...
                                 (Nodes(i).y-Nodes(j).y)^2 );
                
                d_to_obst = SimulationDist([xi yi fi_to_node], KeepOut);
                
                ang = fi-ang_limit : 0.01 : fi+ang_limit;
                xr = r_max*cos(ang) + xi;
                yr = r_max*sin(ang) + yi;
                bool = (0<=xr)&(xr<=2500)&(0<=yr)&(yr<=1800);
                xr = xr(bool);
                yr = yr(bool);
                
                set(hr,'XData',xr,'YData',yr);

                if (d_to_node < r_max)
                    set(hn,'XData',[xi xj],'YData',[yi yj]);
                    
                    if (d_to_node < d_to_obst) 
                        Nodes(i).ConnCount = Nodes(i).ConnCount + 1;
                        Nodes(i).ConnIndex(Nodes(i).ConnCount) = j;
                        Nodes(i).ConnWeight(Nodes(i).ConnCount) = d_to_node;
                    else 
                        xo = d_to_obst*cos(fi_to_node) + xi;
                        yo = d_to_obst*sin(fi_to_node) + yi;
                        set(ho,'XData',[xi xo],'YData',[yi yo]);
                    end

%                     if (89 < i) && (i < 96)
%                         pause(0.1);
%                     end
                end
                
            end
        end
            
    end
    if Nodes(i).ConnCount >= 100
        error('To many connections for node %d within the area! \n', i);
    end
    [Nodes(i).ConnWeight, sortIdx] = sort(Nodes(i).ConnWeight);
    Nodes(i).ConnIndex = Nodes(i).ConnIndex(sortIdx);

end

%%
save('Nodes2','Nodes','d_max_tr_1','d_max_tr_2','d_max_tr_3');
% 
% clear all
% load('Nodes')





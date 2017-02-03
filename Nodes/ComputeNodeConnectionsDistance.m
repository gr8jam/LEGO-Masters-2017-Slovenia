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
Obstacles = InitObstacles(2);

fig = figure;
set(fig, 'Position', [0 170 25*35 18*35]); %% matej
hold on;

colorMap = BarvnaLestvicaRGB_pastel;
DrawPolygonMapColors(fig,colorMap);
DrawNodesPositions(fig,Nodes,0);
DrawObstacles(fig, Obstacles);

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
    d_max = linspace(0,2500,200);
    
    ang = [fi-pi/2-pi/36, fi+pi/2+pi/36];
    xdd = d_max'*cos(ang) + xi;
    ydd = d_max'*sin(ang) + yi;
    
    xdd = reshape(xdd, 1,400);
    ydd = reshape(ydd, 1,400);
    
    xd = xdd(xdd<=2500);
    yd = ydd(xdd<=2500);
    xdd = xd;
    ydd = yd;
    xd = xdd(xdd>=0);
    yd = ydd(xdd>=0);
    
    xdd = xd;
    ydd = yd;
    xd = xdd(ydd<=1800);
    yd = ydd(ydd<=1800);
    xdd = xd;
    ydd = yd;
    xd = xdd(ydd>=0);
    yd = ydd(ydd>=0);
    
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
                
                d_to_obst = SimulationDist([xi yi fi_to_node]);
                
                ang = fi-ang_limit : 0.01 : fi+ang_limit;
                xr = 900*cos(ang) + xi;
                yr = 900*sin(ang) + yi;
                set(hr,'XData',xr,'YData',yr);

                if (d_to_node < 900)
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

                    if (89 < i) && (i < 96)
                        pause(0.5);
                    end
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





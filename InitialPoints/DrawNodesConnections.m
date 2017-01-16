function DrawNodesConnections(fig)
global Nodes d_max_tr_1 d_max_tr_2 d_max_tr_3
if isempty(Nodes)
    error('variable Nodes is empty! \n ');
end
%% Show all nodes as red dots
DrawNodesPositions(fig, 0);

%% Add handels for current node, node area, node connections
hi = plot(1250,900,'g.','MarkerSize',20,'erasemode','xor'); % current node
hd = plot(1250,900,'b-','LineWidth',2,'erasemode','xor');   % current node area
for j = 1:length(Nodes(1).Neighbours)
    hj(j) = plot([0 0],[0 1],'b-','LineWidth',3,'erasemode','xor'); % current node connections
end

%% Go trough all nodes 
i = 1;
while i <= length(Nodes)
    %% Draw current Node
    xi = Nodes(i).x;
    yi = Nodes(i).y;
    set(hi,'XData',xi,'YData',yi);
    
    %% Draw area circle around current Node
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
            d_arrow = 35;
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









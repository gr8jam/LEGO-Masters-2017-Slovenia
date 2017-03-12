function DrawNodesConnections(fig,Nodes)
global NodeConnectionDistanceMax
global NodeConnectionAngleLimit
% global  d_max_tr_1 d_max_tr_2 d_max_tr_3

figure(fig)
hold on;

if isempty(Nodes)
    error('variable Nodes is empty! \n ');
end
%% Show all nodes as red dots
% DrawNodesPositions(fig, Nodes, 0);

%% Add handels for current node, node area, node connections
hi = plot(1250,900,'g.','MarkerSize',20); % current node
hd = plot(1250,900,'b-','LineWidth',2);   % current node area
for j = 1:length(Nodes(1).ConnIndex)
%     hj(j) = plot([0 0],[0 1],'k-','LineWidth',2.6,'erasemode','xor'); % current node connections
    hj(j) = plot([0 0],[0 1],'k-','LineWidth',2.2); % current node connections
end
 
%% Go trough all nodes 
i = 5;
while i <= length(Nodes)
    %% Draw current Node
    xi = Nodes(i).x;
    yi = Nodes(i).y;
    set(hi,'XData',xi,'YData',yi);
    
    %% Draw area circle around current Node
    d_max = NodeConnectionDistanceMax;
    ang = Nodes(i).fi-NodeConnectionAngleLimit : 0.01 : Nodes(i).fi+NodeConnectionAngleLimit;
    xd = d_max*cos(ang) + xi;
    yd = d_max*sin(ang) + yi;
    set(hd,'XData',[xi xd xi],'YData',[yi yd yi]);
    drawnow;
    
    %% Draw connection to current Node's Neighbours
    for j = 1:length(Nodes(i).ConnIndex)
        set(hj(j),'XData',[0 0],'YData',[0 0]);
%         drawnow;
    end
        
    for j = 1:length(Nodes(i).ConnIndex)
        idxj = Nodes(i).ConnIndex(j);
        if (idxj == 0)
            break;
        else
            xj = Nodes(idxj).x;
            yj = Nodes(idxj).y;

            [xarrow, yarrow] = ComputeArrowHead(xi,yi,xj,yj,pi/6,35);
%             hj(j) = plot([xi xj],[yi yj],'b-','LineWidth',2,'erasemode','xor');    
            set(hj(j),'XData',[xi xj xarrow],'YData',[yi yj yarrow]);
            drawnow;
        end
%         pause(0.01);
    end
    
    %% Highlight current node
    Color = [0 255 51]/255;
%     Color = [255 0 102]/255;
    plot(Nodes(i).x,Nodes(i).y,'.','Color',Color,'MarkerSize',25)
    
    selectedPts = mouseinput_timeout(1, gca);
    i = i + 1;
    return
    if ~isempty(selectedPts)
        [xClick,yClick] = ginput(1);
        for k = 1:length(Nodes)
            xk = Nodes(k).x;
            yk = Nodes(k).y;
            
            if (abs(xClick-xk) < 30) && (abs(yClick-yk) < 30)
                i = k;
                fprintf('You selected node %d \n', k);
                break;
            end
        end
    end
end









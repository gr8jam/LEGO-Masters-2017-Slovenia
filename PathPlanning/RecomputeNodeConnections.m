function RecomputeNodeConnections(fig, DRAW, x_ob,y_ob, all)
global Nodes WallsKeepOut ObstaclesKeepOut
global DistanceKeepOut_Obstacles 
global NodeConnectionDistanceMax
global NodeConnectionAngleLimit

if (DRAW)
    %% Init plot handels
    figure(fig);
    hold on;

    hj = plot(1250,900,'b.','MarkerSize',20,'erasemode','xor');
    hi = plot(1250,900,'g.','MarkerSize',20,'erasemode','xor');
    hd = plot(1250,900,'b-','MarkerSize',2);
    hc = plot(1250,900,'b-','LineWidth',3);
    ho = plot(1250,900,'r-','LineWidth',3);
    hr = plot(1250,900,'b-','LineWidth',2);
    ha = plot(1250,900,'y.','MarkerSize',5);

    %% Draw area around new detected obstacle
    ra_max = DistanceKeepOut_Obstacles;
    xa = x_ob;
    ya = y_ob;
    ang = 0:0.01:2*pi+0.01;
    xaa = ra_max*cos(ang) + xa;
    yaa = ra_max*sin(ang) + ya;
%     set(ha,'XData',[xa xaa],'YData',[ya yaa])
end

%% Loop trough all Nodes
for i = 1:length(Nodes)
    if (DRAW)
        %% Draw currnet node
        xi = Nodes(i).x;
        yi = Nodes(i).y;
        fi = Nodes(i).fi;
        set(hi,'XData',xi,'YData',yi);
        
        %% Area around current node  
        rd_max = NodeConnectionDistanceMax;
        ang_limit = NodeConnectionAngleLimit;
        
        % Line
        d_max = linspace(0,rd_max,200);  %
        ang = [fi-ang_limit, fi+ang_limit];
        xdd = d_max'*cos(ang) + xi;
        ydd = d_max'*sin(ang) + yi;
        bool = (0<=xdd)&(xdd<=2500)&(0<=ydd)&(ydd<=1800);
        xd = xdd(bool);
        yd = ydd(bool);
        set(hd,'XData',xd,'YData',yd);
        
        % Radious
        ang = fi-ang_limit : 0.01 : fi+ang_limit;
        xr = rd_max*cos(ang) + xi;
        yr = rd_max*sin(ang) + yi;
        bool = (0<=xr)&(xr<=2500)&(0<=yr)&(yr<=1800);
        xr = xr(bool);
        yr = yr(bool);
        set(hr,'XData',xr,'YData',yr);
    end
  
    %% Debug tool
    if i == 14
        a = 48;
    end
    %     k = waitforbuttonpress;
    
    %% Check if current node and Obstacle KeepOut interect  
%     alfa = atan2(y_ob - Nodes(i).y, x_ob - Nodes(i).x);
%     alfa = wrapToPi(alfa);
%     beta = alfa - Nodes(i).fi;
%     beta = wrapToPi(beta);
%     alfa_deg = alfa * 180 / pi;
%     beta_deg = beta * 180 / pi;
%     
%     if (-NodeConnectionAngleLimit <= beta && beta <= NodeConnectionAngleLimit)
%         % Obstacle is ahead of the node
%         b = 1;
%         if (DRAW)
% %             fprintf('Ahead. \n');
%         end
% %         if (((Nodes(i).x - x_ob)^2 + (Nodes(i).y - y_ob)^2 ) > (NodeConnectionDistanceMax + DistanceKeepOut_Obstacles)^2) 
% %             continue;
% %         end
%     else
%         b = 2;
%         % Obstacle is behind of the node
%         if (DRAW)
% %             fprintf('Behind. \n');
%         end
%         
% %         continue;
%     end

     %% Scalar product
%     cosFi = cos(-Nodes(i).fi);
%     sinFi = sin(-Nodes(i).fi);
%     
%     x_obNew = (x_ob - Nodes(i).x) * cosFi - (y_ob - Nodes(i).y) * sinFi;
%     y_obNew = (x_ob - Nodes(i).x) * sinFi + (y_ob - Nodes(i).y) * cosFi;
%     
%     scalar_prod = 1 * x_obNew + 0 * y_obNew;
%     if (scalar_prod >= 0)
%         c = 1;
%     else
%         % Obstacle is behind of the node
%         c = 2;
%     end
    
    %% Optimized scalar product
    if (~all)
        cosFi = cos(Nodes(i).fi);
        sinFi = sin(Nodes(i).fi); % it is actually minus sin

        x_obNew = (x_ob - Nodes(i).x) * cosFi + (y_ob - Nodes(i).y) * sinFi;
    %     y_obNew = (x_ob - Nodes(i).x) * sinFi + (y_ob - Nodes(i).y) * cosFi;

        scalar_prod = x_obNew; % + 0 * y_obNew;
        if (scalar_prod >= 0)
            % Obstacle is ahead of the node
    %         d = 1;

            if (((Nodes(i).x - x_ob)^2 + (Nodes(i).y - y_ob)^2 ) > (NodeConnectionDistanceMax + DistanceKeepOut_Obstacles)^2) 
                continue;
            end        
        else
            % Obstacle is behind of the node
    %         d = 2;

            if ((x_obNew) < DistanceKeepOut_Obstacles) 
                continue;
            end 
        end
    end
    
    
    
    %% Check
%     if (b ~= c)
%         fprintf('Mismatch ob b and c!!! \n');
% %         k = waitforbuttonpress;
% %         mouseinput_timeout(15);
%         
%     end
%     
%     if (b ~= d)
%         error('Mismatch od c and d!!! \n');
% %         k = waitforbuttonpress;
% %         mouseinput_timeout(15);
%         
%     end
    
    
    
    
    %% Init Connections
    Nodes(i).ConnIndex = zeros(1,100);
    Nodes(i).ConnWeight = ones(1,100) * 99999;
    Nodes(i).ConnCount = 0;
    
    %% Loop trough nodes and connect neighbours in the area
    for j = 1:length(Nodes)      
%         %%  
%         if j == 53
%             a = 48;
%         end
    
        if (DRAW)
            set(hc,'XData',[],'YData',[]);
            set(ho,'XData',[],'YData',[]);
        end
        
        if (i ~= j)
            %% Show j-th node
            if (DRAW)
                xj = Nodes(j).x;
                yj = Nodes(j).y;
                set(hj,'XData',Nodes(j).x,'YData',Nodes(j).y);
            end
        
            %% Check if inside correct angle
            cosFi = cos(Nodes(i).fi);
            sinFi = sin(Nodes(i).fi); % it is actually minus sin

            x_jNew = (Nodes(j).x - Nodes(i).x) * cosFi + (Nodes(j).y - Nodes(i).y) * sinFi;
        %     y_obNew = (x_ob - Nodes(i).x) * sinFi + (y_ob - Nodes(i).y) * cosFi;

            scalar_prod = x_jNew; % + 0 * y_obNew;
            if (scalar_prod >= -0.0001)
%                 
%                 bb = 1;
%             else
%                 bb = 2;
%             end
%             
%             alfa = atan2(Nodes(j).y - Nodes(i).y, Nodes(j).x - Nodes(i).x);
%             beta = alfa - Nodes(i).fi;
%             beta = wrapToPi(beta);
%             
%             alfa_deg = alfa * 180 / pi;
%             beta_deg = beta * 180 / pi;
%             
%             if (-NodeConnectionAngleLimit <= beta && beta <= NodeConnectionAngleLimit)
%                 cc =1;
                %% Check if no 
                

                
                d_to_node = sqrt((Nodes(i).x-Nodes(j).x)^2 + ...
                                 (Nodes(i).y-Nodes(j).y)^2 );
                
                
                if (d_to_node < NodeConnectionDistanceMax)
                    if (DRAW)
                        set(hc,'XData',[xi xj],'YData',[yi yj]);
                    end
                    
                    fi_to_node = atan2(Nodes(j).y - Nodes(i).y, Nodes(j).x - Nodes(i).x);
                
                    d_to_obst = SimulationDist([Nodes(i).x Nodes(i).y fi_to_node],....
                                                WallsKeepOut,ObstaclesKeepOut);
                
                    if (d_to_node < d_to_obst) 
                        Nodes(i).ConnCount = Nodes(i).ConnCount + 1;
                        Nodes(i).ConnIndex(Nodes(i).ConnCount) = j;
                        Nodes(i).ConnWeight(Nodes(i).ConnCount) = d_to_node;
                    else 
                        
                        if (DRAW)
                            xo = d_to_obst*cos(fi_to_node) + Nodes(i).x;
                            yo = d_to_obst*sin(fi_to_node) + Nodes(i).y;
                            set(ho,'XData',[Nodes(i).x xo],'YData',[Nodes(i).y yo]);
                        end
                    end

                    if (DRAW)
%                         pause(0.01);
                    end
                end
                
%             else
%                 cc = 2;
%                 
            end
            
%             if (bb ~= cc)
%                 fprintf('Mismatch od c and d!!! \n');
%         %         k = waitforbuttonpress;
%         %         mouseinput_timeout(15);
% 
%             end
        end
        
            
    end
    if Nodes(i).ConnCount >= 100
        error('To many connections for node %d within the area! \n', i);
    end
    [Nodes(i).ConnWeight, sortIdx] = sort(Nodes(i).ConnWeight);
    Nodes(i).ConnIndex = Nodes(i).ConnIndex(sortIdx);
    
    pause(0.01);
end

if (DRAW)
    set(hj,'XData',1250,'YData',900)
    set(hi,'XData',1250,'YData',900)
    set(hd,'XData',1250,'YData',900)
    set(hc,'XData',1250,'YData',900)
    set(ho,'XData',1250,'YData',900)
    set(hr,'XData',1250,'YData',900)
    % set(ha,'XData',1250,'YData',900)
end

end


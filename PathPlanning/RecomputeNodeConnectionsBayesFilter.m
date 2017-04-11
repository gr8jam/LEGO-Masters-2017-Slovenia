function RecomputeNodeConnectionsBayesFilter(fig, DRAW, x_ob,y_ob, all, init)
global Nodes WallsKeepOut ObstaclesKeepOut
global DistanceKeepOut_Obstacles 
global NodeConnectionDistanceMax

TrackChangeFactor = 2;

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
    set(ha,'XData',[xa xaa],'YData',[ya yaa])
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
        dr = 220;
        wr = 200;
        Ar = [xi yi]' + wr*[cos(fi - pi/2) sin(fi - pi/2) ]';
        Br = [xi yi]' + wr*[cos(fi + pi/2) sin(fi + pi/2) ]';
        Cr = Br + dr*[cos(fi) sin(fi)]';
        Dr = Ar + dr*[cos(fi) sin(fi)]';
        
%         rd_max = NodeConnectionDistanceMax;
%         ang_limit = NodeConnectionAngleLimit;
%         
%         % Line
%         d_max = linspace(0,rd_max,200);  %
%         ang = [fi-ang_limit, fi+ang_limit];
%         xdd = d_max'*cos(ang) + xi;
%         ydd = d_max'*sin(ang) + yi;
%         bool = (0<=xdd)&(xdd<=2500)&(0<=ydd)&(ydd<=1800);
%         xd = xdd(bool);
%         yd = ydd(bool);
%         set(hd,'XData',xd,'YData',yd);
%         
%         % Radious
%         ang = fi-ang_limit : 0.01 : fi+ang_limit;
%         xr = rd_max*cos(ang) + xi;
%         yr = rd_max*sin(ang) + yi;
%         bool = (0<=xr)&(xr<=2500)&(0<=yr)&(yr<=1800);
%         xr = xr(bool);
%         yr = yr(bool);

        set(hr,'XData',[Ar(1) Br(1) Cr(1) Dr(1) Ar(1)],'YData',[Ar(2) Br(2) Cr(2) Dr(2) Ar(2)]);
    end
  
    %% Debug tool
    if i == 51
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
    if (~all) && (~init)
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

            if (abs(x_obNew) > DistanceKeepOut_Obstacles) 
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
    Nodes(i).BFconnIdxR = zeros(3,1);
    Nodes(i).BFconnWghR = ones(3,1) * 99999;
    Nodes(i).BFconnCntR = 0;
    
    Nodes(i).BFconnIdxL = zeros(3,1);
    Nodes(i).BFconnWghL = ones(3,1) * 99999;
    Nodes(i).BFconnCntL = 0;
    
    Nodes(i).BFconnIdxF = zeros(1,1);
    Nodes(i).BFconnWghF = ones(1,1) * 99999;
    Nodes(i).BFconnCntF = 0;
    
    j = (i + 1);
    iTrack = ceil(i/32);
    switch iTrack
        case 1
%             if (j < 1)
%                 j = 32 + j;
%             end
            if (j > 32)
                j = j - 32;
            end
        case 2
%             if (j < 33)
%                 j = 32 + j;
%             end
            if (j > 64)
                j = j - 32;
            end
        case 3
%             if (j < 65)
%                 j = 32 + j;
%             end
            if (j > 96)
                j = j - 32;
            end
        otherwise
            error('Wrong track \n');
    end   
    
    
    d_to_node = sqrt((Nodes(i).x-Nodes(j).x)^2 + ...
                     (Nodes(i).y-Nodes(j).y)^2 );
    
    fi_to_node = atan2(Nodes(j).y - Nodes(i).y, Nodes(j).x - Nodes(i).x);
    
    if (~all)
        d_to_obst = SimulationDist([Nodes(i).x Nodes(i).y fi_to_node],....
                                    WallsKeepOut,ObstaclesKeepOut);
    else
        d_to_obst = SimulationDist([Nodes(i).x Nodes(i).y fi_to_node],WallsKeepOut,[]);
    end
    
    if (d_to_node < d_to_obst)
        Nodes(i).BFconnIdxF = j;
        Nodes(i).BFconnWghF = d_to_node;
        Nodes(i).BFconnCntF = Nodes(i).BFconnCntF + 1;
    end
    
        
    %% Loop trough nodes and connect neighbours in the area
    for j = 1:96 %length(Nodes)      
%         %%  
%         if j == 53
%             a = 48;
%         end
    
        if (DRAW)
            set(hc,'XData',[],'YData',[]);
            set(ho,'XData',[],'YData',[]);
        end
        
        
        jTrack = ceil(j/32);
        
        if (iTrack ~= jTrack)
        
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
            if (scalar_prod >= 30) % 30 mm forward
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
                
                    if (~init)
                        d_to_obst = SimulationDist([Nodes(i).x Nodes(i).y fi_to_node],....
                                                    WallsKeepOut,ObstaclesKeepOut);
                    else
                        d_to_obst = SimulationDist([Nodes(i).x Nodes(i).y fi_to_node],WallsKeepOut,[]);
                    end
                
                    
                    if (d_to_node < d_to_obst) 
                        switch iTrack
                            case 1
                                switch jTrack
                                    case 1
                                        error('Same track! \n')
                                    case 2
                                        Nodes(i).BFconnCntL = Nodes(i).BFconnCntL + 1;
                                        Nodes(i).BFconnIdxL(Nodes(i).BFconnCntL) = j;
                                        Nodes(i).BFconnWghL(Nodes(i).BFconnCntL) = d_to_node * TrackChangeFactor;
%                                         Nodes(i).BFconnCntL = Nodes(i).BFconnCntL + 1;
                                    case 3
                                        % Dubble track change is not
                                        % allowed
                                end
                                
                            case 2
                                switch jTrack
                                    case 1
                                        Nodes(i).BFconnCntR = Nodes(i).BFconnCntR + 1;
                                        Nodes(i).BFconnIdxR(Nodes(i).BFconnCntR) = j;
                                        Nodes(i).BFconnWghR(Nodes(i).BFconnCntR) = d_to_node * TrackChangeFactor;
%                                         Nodes(i).BFconnCntR = Nodes(i).BFconnCntR + 1;
                                    case 2
                                        error('Same track! \n')
                                    case 3
                                        Nodes(i).BFconnCntL = Nodes(i).BFconnCntL + 1;
                                        Nodes(i).BFconnIdxL(Nodes(i).BFconnCntL) = j;
                                        Nodes(i).BFconnWghL(Nodes(i).BFconnCntL) = d_to_node * TrackChangeFactor;
%                                         Nodes(i).BFconnCntL = Nodes(i).BFconnCntL + 1;
                                end
                                
                            case 3
                                switch jTrack
                                    case 1
                                        % Dubble track change is not
                                        % allowed
                                    case 2
                                        Nodes(i).BFconnCntR = Nodes(i).BFconnCntR + 1;
                                        Nodes(i).BFconnIdxR(Nodes(i).BFconnCntR) = j;
                                        Nodes(i).BFconnWghR(Nodes(i).BFconnCntR) = d_to_node * TrackChangeFactor;
%                                         Nodes(i).BFconnCntR = Nodes(i).BFconnCntR + 1;
                                    case 3
                                        error('Same track! \n')
                                end
                        end
                                   
                        
                    else 
                        if (DRAW)
                            xo = d_to_obst*cos(fi_to_node) + Nodes(i).x;
                            yo = d_to_obst*sin(fi_to_node) + Nodes(i).y;
                            set(ho,'XData',[Nodes(i).x xo],'YData',[Nodes(i).y yo]);
                        end
                    end

                    if (DRAW)
                        pause(0.01);
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
    if Nodes(i).BFconnCntF > 1
        error('To many forward connections for node %d within the area! \n', i);
    end
%     [Nodes(i).ConnWeight, sortIdx] = sort(Nodes(i).ConnWeight);
%     Nodes(i).ConnIndex = Nodes(i).ConnIndex(sortIdx);
    
%     pause(0.01);
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


function task_PathPlanning()
% global Flag_RecalculatePath
global  PP PF TrueObstacleCenters Nodes % Flag_RecalculatePath Flag_PathFound Path Goal
global ObstaclesKeepOut

% persistent Flag_RecalculatePath
% if (isempty(Flag_RecalculatePath))
%     Flag_RecalculatePath = false;
% end

% if (isempty(Flag_PathFound))
%     Flag_PathFound = false;
% end



if (PP.Flag_RecalculatePath)    
    ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);
    
    for i = 1:length(TrueObstacleCenters)
        x = TrueObstacleCenters(i,1);
        y = TrueObstacleCenters(i,2);
        tic;
        RecomputeNodeConnections(10,false,x,y,false);
        duration = toc;
        fprintf('Duration = %1.3f s\n', duration);
    end

    StartIdx = GetClosestNode();
    ComputeDijkstra(StartIdx);
    StopIdx = GetStopIdx(StartIdx); 
    ComputeOptimalPathDijkstra(StartIdx, StopIdx);
    
    PP.Goal = PP.Path(PP.lenPath);
    PP.xRef = Nodes(PP.Goal).x;
    PP.yRef = Nodes(PP.Goal).y;
    
    PP.Flag_RecalculatePath = false;
    PP.Flag_PathFound = true;
end

if (PP.Flag_PathFound && (PP.lenPath > 0))
    SwitchGoal();
end







end

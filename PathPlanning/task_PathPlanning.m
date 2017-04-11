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
    StartIdx = GetClosestNode();
%     StartIdx = 81;
    ComputeDijkstra(StartIdx);
    StopIdx = GetStopIdx(StartIdx); 
    StopIdx = 50;
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

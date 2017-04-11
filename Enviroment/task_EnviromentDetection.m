function task_EnviromentDetection(i)
global Ts ObstaclesKeepOut TrueObstacleCenters 
global PP

persistent time
if (isempty(time))
    time = 5;
end

persistent cntObst
if (isempty(cntObst))
    cntObst = 0;
end


ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);

if (Ts*i > time) && (cntObst < 1)
    time = time + 0;
    cntObst = cntObst + 1;
    
    x = TrueObstacleCenters(cntObst,1);
    y = TrueObstacleCenters(cntObst,2);
    tic;
    DRAW = false;
    all = true;
    init = false;
    RecomputeNodeConnections(10,DRAW,x,y,all,init);
    duration = toc;
    fprintf('Duration = %1.3f s\n', duration);

    PP.Flag_RecalculatePath = true;
end


end

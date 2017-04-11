function task_EnviromentDetection(i)
global Ts ObstaclesKeepOut TrueObstacleCenters 
global PP

persistent time
if (isempty(time))
    time = 0;
end

persistent cnt
if (isempty(cnt))
    cnt = 0;
end


ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);

if (Ts*i > time) && (cnt < 4)
    time = time + 0;
    cnt = cnt + 1;
    
    x = TrueObstacleCenters(cnt,1);
    y = TrueObstacleCenters(cnt,2);
    tic;
    DRAW = false;
    all = false;
    init = true;
    RecomputeNodeConnections(10,DRAW,x,y,all,init);
    duration = toc;
    fprintf('Duration = %1.3f s\n', duration);

    PP.Flag_RecalculatePath = true;
end


end

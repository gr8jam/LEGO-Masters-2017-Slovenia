function task_EnviromentDetection(i)
global Ts ObstaclesKeepOut TrueObstacleCenters 
global PP

persistent time
if (isempty(time))
    time = 15;
end

persistent cnt
if (isempty(cnt))
    cnt = 0;
end


ObstaclesKeepOut = ComputeObstaclesKeepOut(TrueObstacleCenters);

if (Ts*i > time) && (cnt < 4)
    time = time + 1;
    cnt = cnt + 1;
    
    x = TrueObstacleCenters(cnt,1);
    y = TrueObstacleCenters(cnt,2);
    tic;
    RecomputeNodeConnections(10,false,x,y,false);
    duration = toc;
    fprintf('Duration = %1.3f s\n', duration);

    PP.Flag_RecalculatePath = true;
end


end

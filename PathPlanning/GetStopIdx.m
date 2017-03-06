function StopIdx = GetStopIdx(StartIdx)
global Nodes
StopIdx = StartIdx - 1;

whileRun = true;
while (whileRun)
    %% TODO: check if on a valid list
    if (StopIdx ~= 0) %&& (Nodes(StopIdx).valid) 
        whileRun = false;
    else
        StopIdx = StopIdx - 1;
    end
    
end
end


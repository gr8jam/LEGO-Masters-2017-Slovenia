function StopIdx = GetStopIdx(StartIdx)
global Nodes
StopIdx = StartIdx - 1;

if (StartIdx == 65)
    StopIdx = 96;
end

if (StartIdx == 33)
    StopIdx = 64;
end

if (StartIdx == 1)
    StopIdx = 32;
end

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


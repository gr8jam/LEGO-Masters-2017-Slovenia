function ComputeOptimalPathDijkstra(StartIdx, StopIdx)

global PP Nodes

NextIdx = StopIdx;
PP.lenPath = 0;
PP.cntPath = 0;

cnt = 0;

while (NextIdx ~= StartIdx)
    PP.lenPath = PP.lenPath + 1;
    PP.Path(PP.lenPath) = NextIdx;
    NextIdx = Nodes(NextIdx).path;
    
    
    cnt = cnt + 1;
    if cnt > 10000
        error('Dijkstra error!')
    end
end

%% Only for viewing
% PP.lenPath = PP.lenPath + 1;
% PP.Path(PP.lenPath) = StartIdx;

end


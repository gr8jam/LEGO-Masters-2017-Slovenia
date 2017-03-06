function ComputeOptimalPathDijkstra(StartIdx, StopIdx)

global PP Nodes

NextIdx = StopIdx;
PP.lenPath = 0;
PP.cntPath = 0;

while (NextIdx ~= StartIdx)
    PP.lenPath = PP.lenPath + 1;
    PP.Path(PP.lenPath) = NextIdx;
    NextIdx = Nodes(NextIdx).path;
end

end


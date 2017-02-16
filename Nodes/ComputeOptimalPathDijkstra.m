function [OptimalPath] = ComputeOptimalPathDijkstra(Nodes, StartIdx, StopIdx)

NextIdx = StopIdx;
Path = [NextIdx];
while (NextIdx ~= StartIdx)
    try
        
        NextIdx = Nodes(NextIdx).path;
        Path = [Path NextIdx];
    catch exception
        statements = 1;
   
    end
end

OptimalPath = Path(end:-1:1);

end
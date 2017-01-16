function [OptimalPath] = ComputeOptimalPathDijkstra(Nodes, StartIdx, StopIdx)

NextIdx = StopIdx;
Path = [NextIdx];
while (NextIdx ~= StartIdx)
    NextIdx = Nodes(NextIdx).path;
    Path = [Path NextIdx];
end

OptimalPath = Path(end:-1:1);

end
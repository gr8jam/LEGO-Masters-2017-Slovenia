function Obstacles = ComputeObstacles(ObstaclesCenters, d)
Obstacles = [];

for i = 1:size(ObstaclesCenters,1)
    OctagonLines = GetOctagonLines(ObstaclesCenters(i,1), ObstaclesCenters(i,2), d);
    Obstacles = [Obstacles;
                 OctagonLines];
end

end

function Obstacles = ComputeObstacles(ObstacleCenters, d)
Obstacles = [];

for i = 1:size(ObstacleCenters,1)
    OctagonLines = GetOctagonLines(ObstacleCenters(i,1), ObstacleCenters(i,2), d);
    Obstacles = [Obstacles;
                 OctagonLines];
end

end

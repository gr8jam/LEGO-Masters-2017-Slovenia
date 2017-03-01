function GenerateWalls
addpath('../TrueWorld');
load('TrueWalls.mat');

Walls = TrueWalls;
save('Walls.mat' ,'Walls');

end

function Obstacles = InitObstacles(f)
%% Parameter f
% f = 1 : manually select obstacles
% f = 2 : load previouslly selected obstacles
Walls = [];
load('Walls.mat');
if f == 1
    fprintf('Izberi pozicijo štirih ovir \n\r')
    [x,y] = ginput(4);  
    save('SrediscaOvir.mat','x','y')
    obst = GetObstacleVertex( x,y );     
elseif f == 2
    x = 0;
    y = 0;
    load('SrediscaOvir.mat');
    obst = GetObstacleVertex( x,y );
end

Obstacles = [Walls; obst];
% Obstacles = Walls;
end
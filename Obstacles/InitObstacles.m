function Obstacles = InitObstacles(f)
%% Parameter f
% f = 1 : manually select obstacles
% f = 2 : load previouslly selected obstacles

Obstacles = [];
if f == 1
    fprintf('Izberi pozicijo štirih ovir \n\r')
    [x,y] = ginput(4);  
    Obstacles = [x y];
    save('Obstacles.mat','Obstacles')    
elseif f == 2
    load('Obstacles.mat');
end

end
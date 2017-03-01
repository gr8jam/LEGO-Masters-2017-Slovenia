function TrueObstaclesCenters = InitTrueObstacleCenters(f)
%% Parameter f
% f = 1 : manually select obstacles
% f = 2 : load previouslly selected obstacles

TrueObstaclesCenters = [];
if f == 1
    fprintf('Izberi pozicijo štirih ovir \n\r')
    [x,y] = ginput(4);  
    TrueObstaclesCenters = [x y];
    save('TrueObstaclesCenters.mat', 'TrueObstaclesCenters') 
elseif f == 2
    load('TrueObstaclesCenters.mat');
end

end
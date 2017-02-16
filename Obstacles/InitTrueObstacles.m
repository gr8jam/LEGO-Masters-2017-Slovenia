function TrueObstacles = InitTrueObstacles(f)
%% Parameter f
% f = 1 : manually select obstacles
% f = 2 : load previouslly selected obstacles

TrueObstacles = [];
if f == 1
    fprintf('Izberi pozicijo štirih ovir \n\r')
    [x,y] = ginput(4);  
    TrueObstacles = [x y];
    save('TrueObstacles.mat','TrueObstacles')    
elseif f == 2
    load('TrueObstacles.mat');
end

end
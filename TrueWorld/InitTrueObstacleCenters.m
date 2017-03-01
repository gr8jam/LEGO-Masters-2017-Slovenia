function TrueObstacleCenters = InitTrueObstacleCenters(f)
%% Parameter f
% f = 1 : manually select obstacles
% f = 2 : load previouslly selected obstacles

TrueObstacleCenters = [];
if f == 1
    fprintf('Izberi pozicijo štirih ovir \n\r')
    [x,y] = ginput(4);  
    TrueObstacleCenters = [x y];
    save('TrueObstacleCenters.mat', 'TrueObstacleCenters') 
elseif f == 2
    load('TrueObstacleCenters.mat');
end

end
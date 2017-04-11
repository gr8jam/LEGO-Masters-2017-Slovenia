function TrueObstaclesCenters = InitTrueObstacleCenters(f)
%% Parameter f
% f = 1 : manually select obstacles
% f = 2 : load previouslly selected obstacles

TrueObstaclesCenters = [];
if f == 1
    load('TrueRobot.mat');
    fprintf('Izberi pozicijo štirih ovir \n\r')
    xx = [];
    yy = [];
    cnt = 0;
    while cnt < 4
        [x,y] = ginput(1); 
        valid = 0;
        
        if (sqrt((TrueRobot.q(1)-x)^2+(TrueRobot.q(1)-y)^2) > 300)
            for i = 1:length(xx)
                if (sqrt((xx(i)-x)^2+(yy(i)-y)^2) > 300)
                    valid = valid + 1;
                end 
            end
        end
        
        if (valid == length(xx))
            xx = [xx; x];
            yy = [yy; y];
            cnt = cnt+1;
            fprintf('Ovira številka %i izbrana \n', cnt)
        else
            fprintf('Ponovno izberi oviro številka %i \n', cnt+1)
        end
        
        
    end
    TrueObstaclesCenters = [xx yy];
    save('TrueObstaclesCenters.mat', 'TrueObstaclesCenters') 
elseif f == 2
    load('TrueWorld/TrueObstaclesCenters.mat');
end

end
function TrueRobot = InitTrueRobot(f)
%% Parameter f
% f = 1 : manually select TrueRobot position
% f = 2 : load previouslly selected TrueRobot position
% f = 3 : randomly choose TrueRobot position

global Nodes

TrueRobot = struct('R', 0.05,...
                   'L', 0.15,...
                   'q', [0 0 0]'); 
               
switch f
    case 1
        fprintf('Izberi pozicijo Robota. \n\r')
        
        [x,y] = ginput(1); 
        distOld = 99999; 
        StartIdx = 0;

        for i = 1:96
            dist = sqrt((Nodes(i).x - x)^2 + (Nodes(i).y - y)^2);
            if dist < distOld
                distOld = dist;
                StartIdx = i;
            end
        end
        
        noise = 15;
        TrueRobot.q(1) = Nodes(StartIdx).x + randi([-noise noise]);
        TrueRobot.q(2) = Nodes(StartIdx).y + randi([-noise noise]);
        TrueRobot.q(3) = Nodes(StartIdx).fi + randi([-noise noise])*pi/180;
        
        save('TrueWorld/TrueRobot.mat' ,'TrueRobot') 
        
    case 2
        load('TrueRobot.mat');
    
    case 3
        StartIdx = randi([1 96]);
        
        TrueRobot.q(1) = Nodes(StartIdx).x + randi([-5 5]);
        TrueRobot.q(2) = Nodes(StartIdx).y + randi([-5 5]);
        TrueRobot.q(3) = Nodes(StartIdx).fi + randi([-5 5])*pi/180;
        
        save('TrueWorld/TrueRobot.mat' ,'TrueRobot');
    
    otherwise
        error('Parameter error! \n')
        
end


      
end



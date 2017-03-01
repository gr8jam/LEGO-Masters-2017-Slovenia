function InitParticles()
global Robot

% global PolygonMapColors
% global Walls WallsKeepOut
% global ObstaclesCenters Obstacles ObstaclesKeepOut
global Nodes %Path Goal
global PF 
% global Motion
global SenRGB %SenDist SenGyro


idxL = SenRGB.Left.idx;
idxR = SenRGB.Right.idx;

% if (idxL ~= idxL2) || (idxR ~= idxR2)
%     idxL2 = 1;
% end

for p = 1:PF.nParticles   
    cnt = 0;
    not_done = true;
    while not_done
        cnt = cnt +1;
        idxNode = randi(96);
        
        PF.xP(1,p) = Nodes(idxNode).x + randi([5 5]);
        PF.xP(2,p) = Nodes(idxNode).y + randi([-5 5]);
        PF.xP(3,p) = Nodes(idxNode).fi + randi([-10 10])*pi/180;
       
        [idxLxP, idxRxP] = SimulationRGB(PF.xP(:,p));
        if ((idxL == idxLxP) && (idxR == idxRxP))  
            not_done = false;
        end
        
        if (cnt > 10000) 
            error('PF could not find matching particle! \n');
        end
    end
%     xP(3,p) = xP(3,p) * 2*pi - pi;
%     xP(3,p) = Robot.fi;
%     xP(3,p) = TrueRobot.q(3);
    
    
end

% xP = repmat(q0,1,nParticles)+ diag([300,300,2*pi] )*rand(3,nParticles) - ([300,300,2*pi]'*.5*ones(1,nParticles)); % inicicalizacija delcev

% xP = rand(3,nParticles);
% xP(1,:) = xP(1,:) * 2499 + 1;
% xP(2,:) = xP(2,:) * 1799 + 1;
% xP(3,:) = xP(3,:) * 2*pi - pi;

PF.xP(3,:) = wrapToPi(PF.xP(3,:));

qMean = mean(PF.xP,2);
Robot.q = qMean;

end




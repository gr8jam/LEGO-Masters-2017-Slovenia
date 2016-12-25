function qMean = InitParticleFilter
global Robot TrueRobot

idxL = Robot.idxL;
idxR = Robot.idxR;

nParticles=600;
xP = zeros(3,nParticles);
for p = 1:nParticles
    
    not_done = true;
    while not_done
        xP(:,p) = rand(3,1);
        xP(1,p) = int32(xP(1,p) * 2499 + 1);
        xP(2,p) = int32(xP(2,p) * 1799 + 1);
        
        [idxLxP, idxRxP] = SimulationRGB(xP(:,p), 0);
        if ((idxL == idxLxP) && (idxR == idxRxP)) 
%         if ((idxR == idxRxP)) 
            not_done = false;
        end
    end
%     xP(3,p) = xP(3,p) * 2*pi - pi;
    xP(3,p) = TrueRobot.q(3);
    
    
end
% xP = repmat(q0,1,nParticles)+ diag([300,300,2*pi] )*rand(3,nParticles) - ([300,300,2*pi]'*.5*ones(1,nParticles)); % inicicalizacija delcev

% xP = rand(3,nParticles);
% xP(1,:) = xP(1,:) * 2499 + 1;
% xP(2,:) = xP(2,:) * 1799 + 1;
% xP(3,:) = xP(3,:) * 2*pi - pi;
Robot.xP = xP;
qMean = mean(xP,2);

end
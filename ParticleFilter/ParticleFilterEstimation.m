function Estimate = ParticleFilterEstimation()

global Robot Ts

persistent errCnt
if isempty(errCnt)
    errCnt = 0;
end

% [idxL, idxR] = SimulationRGB(Robot.q);
% 
% if (Robot.idxL == idxL) && (Robot.idxR == idxR)
%     errCnt = 0;
% else
%     errCnt = errCnt +1;
% end
% 
% if errCnt > 50000
%     Estimate = true;
%     errCnt = 0;
% else
%     Estimate = false;
% end



% Estimate = 'Working';
% Estimate = 'Searching';
% Estimate = 'Error';

for i = 1:Robot.PF.nParticles
    dist = (Robot.PF.xP(1,i) - Robot.q(1)) + (Robot.PF.xP(2,i) - Robot.q(2));
    
    if (dist > 25)
        if errCnt > 5/Ts;
            Estimate = 'Error';
            errCnt = 0;
        else
            Estimate = 'Searching';
        end
        break;
    end
    
    Estimate = 'Working';
end

end
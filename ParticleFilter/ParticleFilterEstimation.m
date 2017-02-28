function Estimate = ParticleFilterEstimation()

global Robot Ts

persistent errCnt
if isempty(errCnt)
    errCnt = 0;
end

persistent validCnt
if isempty(validCnt)
    validCnt = 0;
end

Working = 1;
Searching = 2;
Error = 3;

persistent EstimateState
if isempty(EstimateState)
    EstimateState = Searching;
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


zTrueL = Robot.idxL;
zTrueR = Robot.idxR;

[zL, zR] = SimulationRGB(Robot.q);



DEBUG = false;

switch EstimateState
    case Working
        if (zTrueL == zL) && (zTrueR == zR)
            errCnt = 0;
        else
            errCnt = errCnt +1;
        end

        if errCnt > 3/Ts
            EstimateState = Searching;
            DEBUG = true;
        else
            EstimateState = Working;
        end
        
    case Searching
        if (zTrueL == zL) && (zTrueR == zR)
            validCnt = validCnt +1;
        else
            validCnt = 0;
        end

        if validCnt > 1/Ts
            EstimateState = Working;
            DEBUG = true;
        else
            EstimateState = Searching;
        end
        
    otherwise
        error('Unknown EstimateState');
        
end


% Estimate = 'Working';    ....1
% Estimate = 'Searching';  ....2
% Estimate = 'Error';      ....3

switch EstimateState
    case Working
        Estimate = 'Working';
    case Searching
        Estimate = 'Searching';
end

% DEBUG = true;
if (DEBUG) fprintf('PF estimate is %s. \n', Estimate); end;


% errCntPar = 0;
%
% for i = 1:Robot.PF.nParticles
%     dist = (Robot.PF.xP(1,i) - Robot.q(1))^2 + (Robot.PF.xP(2,i) - Robot.q(2))^2;
%     
%     Robot.q(1);
%     
%     if (dist > 121)
%         errCntPar = errCntPar +1;
%         Estimate = 'Searching';
%         if errCntPar > Robot.PF.nParticles * 0.10;
%             
%             if errCnt > 1/Ts;
%                 Estimate = 'Error';
%                 errCnt = 0;
%             else
%                 Estimate = 'Searching';
%             end
%             break;
%         end
%     
%     else 
%         Estimate = 'Working';
%     end
%     
%     
%     
% end


end
function ParticleFilterEstimation()

global Ts
global PF PP
global SenRGB

persistent errorCnt
if isempty(errorCnt)
    errorCnt = 0;
end

persistent validCnt
if isempty(validCnt)
    validCnt = 0;
end

zTrueL = SenRGB.Left.idx;
zTrueR = SenRGB.Right.idx;
[zL, zR] = SimulationRGB(PF.x, PF.y, PF.fi);


% Estimate = 'Working';    ....1
% Estimate = 'Searching';  ....2

DEBUG = false;

for p = 1:PF.nParticles
    if abs(PF.x - PF.xParticles(1,p)) > 200
        return
    end
    if abs(PF.y - PF.xParticles(2,p)) > 200
        return
    end
end


if (zTrueL == zL) && (zTrueR == zR)           
    if (validCnt < 1000000)
        validCnt = validCnt + 1;
    end
    if (validCnt > 5)
        errorCnt = 0;
    end

else
    if (errorCnt < 1000000)
        errorCnt = errorCnt +1;
    end
    if (errorCnt > 5)
        validCnt = 0;
    end
end

if validCnt > 2/Ts
    if  strcmp(PF.Estimate,'Searching')
        DEBUG = true;
        PF.Estimate = 'Working';
        PP.Flag_RecalculatePath = true;
    end

elseif errorCnt > 2/Ts
    if  strcmp(PF.Estimate,'Working')
        DEBUG = true;
    end
    errorCnt = 5;
    PF.Estimate = 'Searching';
    PF.Flag_Reinit = true;

    

end

if (DEBUG) fprintf('PF estimate is %s. \n', PF.Estimate); end;

% 
% 
% switch PF.Estimate
%     case 'Working'
%         
%         
%     case 'Searching'
%         
%         if validCnt > 2/Ts
%             PF.Estimate = 'Working';
%             errorCnt = 0;
%             validCnt = 0;
%             PP.Flag_RecalculatePath = true;
%             DEBUG = true;
% 
%         elseif errorCnt > 2/Ts
%             PF.Estimate = 'Searching';
%             PF.Flag_RecalculatePath = true;
%             DEBUG = true;
%         end
% 
%     otherwise
%         error('Unknown EstimateState');
%         
% end


% DEBUG = true;


end



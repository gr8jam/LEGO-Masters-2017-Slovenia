function ParticleFilterEstimation()

global Ts
% global PolygonMapColors
% global Walls WallsKeepOut
% global ObstaclesCenters Obstacles ObstaclesKeepOut
% global Nodes Path Goal
global PF 
% global Motion
global SenRGB %SenDist SenGyro

persistent errCnt
if isempty(errCnt)
    errCnt = 0;
end

persistent validCnt
if isempty(validCnt)
    validCnt = 0;
end

% Working = 1;
% Searching = 2;
% Error = 3;
% 
% persistent EstimateState
% if isempty(EstimateState)
%     EstimateState = Searching;
% end



zTrueL = SenRGB.Left.idx;
zTrueR = SenRGB.Right.idx;
[zL, zR] = SimulationRGB(PF.q);


DEBUG = false;

switch PF.Estimate
    case 'Working'
        if (zTrueL == zL) && (zTrueR == zR)
            errCnt = 0;
        else
            errCnt = errCnt +1;
        end

        if errCnt > 1/Ts
            PF.Estimate = 'Searching';
            DEBUG = true;
        else
            PF.Estimate = 'Working';
        end
        
    case 'Searching'
        if (zTrueL == zL) && (zTrueR == zR)
            validCnt = validCnt +1;
        else
            validCnt = 0;
        end

        if validCnt > 1/Ts
            PF.Estimate = 'Working';
            DEBUG = true;
        else
            PF.Estimate = 'Searching';
        end
        
    otherwise
        error('Unknown EstimateState');
        
end


% Estimate = 'Working';    ....1
% Estimate = 'Searching';  ....2
% Estimate = 'Error';      ....3

% switch EstimateState
%     case Working
%         PF.Estimate = 'Working';
%     case Searching
%         PF.Estimate = 'Searching';
% end

% DEBUG = true;
if (DEBUG) fprintf('PF estimate is %s. \n', PF.Estimate); end;


end
function [v,w] = Controler(q)

global Robot 

% global PolygonMapColors
% global Walls WallsKeepOut
% global ObstaclesCenters Obstacles ObstaclesKeepOut
global Nodes Path Goal
global PF 
global Motion
global SenRGB SenDist SenGyro

persistent w_sen
if isempty(w_sen)
    w_sen = 0;
end

persistent Flag_RecalculatePath
if isempty(Flag_RecalculatePath)
    Flag_RecalculatePath = 0;
end

persistent q_path
if isempty(q_path)
    q_path = 0;
end

DEBUG = true;

if strcmp(PF.Estimate,'Searching')
    MotionState = 'LineTracking';
    Flag_RecalculatePath = true;

elseif strcmp(PF.Estimate, 'Working')
    MotionState = 'Point2Point';
else
    if (DEBUG) fprintf('Robot STOP. \n'); end;
    error('Robot STOP. \n');
    MotionState = 'Stop';
end

switch MotionState
    case 'LineTracking'
        [T,v,w] = evalc('LineTracking(Robot.q);');
        
    case 'Point2Point'
        q_sen = PF.q;
        
        if (Flag_RecalculatePath)
%             q_path = GetOptimalpath();
            Path = [20 25 30 35 40 45 50 52 55 90 93 65 68 75];
            Flag_RecalculatePath = false;
        end
            
        q_ref = SwitchRefPos(q_sen);
        [v,w] = ContolerPosition(q_ref, q_sen, w_sen);
        
        w_sen = w;
        Goal = q_ref;
        
        
%         if (DEBUG) fprintf('v = %4.2f \nw = %4.2f \n', v,w); end;
%         if (DEBUG) fprintf('x = %4.2f \ny = %4.2f \n\n', q_ref(1),q_ref(2)); end;
        
    case 'Stop'
        v = 0;
        w = 0;
        
    otherwise
        error('MotionState in unkonwn state. \n')
end

end
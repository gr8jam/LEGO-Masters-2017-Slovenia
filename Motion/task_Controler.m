function [vv,ww] = task_Controler()

% global Nodes Path Goal
global PF PP
global Motion
global SenRGB SenDist SenGyro
global v w % Flag_RecalculatePath Flag_PathFound

persistent w_sen
if isempty(w_sen)
    w_sen = 0;
end

% persistent Flag_RecalculatePath
% if isempty(Flag_RecalculatePath)
%     Flag_RecalculatePath = 0;
% end


persistent MotionState
if isempty(MotionState)
    MotionState = 'LineTracking';
end

DEBUG = true;

if strcmp(PF.Estimate,'Searching')
    MotionState = 'LineTracking';

elseif strcmp(PF.Estimate, 'Working')
    if (PP.Flag_PathFound)
        MotionState = 'Point2Point';
    end
else
    if (DEBUG) fprintf('Robot STOP. \n'); end;
    error('Robot STOP. \n');
    MotionState = 'Stop';
end

switch MotionState
    case 'LineTracking'
        [T,v,w] = evalc('LineTracking();');
        
        
    case 'Point2Point'
        [v,w] = ContolerPosition(w_sen);
        
        w_sen = w;
        
        
        
%         if (DEBUG) fprintf('v = %4.2f \nw = %4.2f \n', v,w); end;
%         if (DEBUG) fprintf('x = %4.2f \ny = %4.2f \n\n', q_ref(1),q_ref(2)); end;
        
    case 'Stop'
        v = 0;
        w = 0;
        
    otherwise
        error('MotionState in unkonwn state. \n')
end

vv = v;
ww = w;
end
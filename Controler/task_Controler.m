function [vv,ww] = task_Controler()

% global Nodes Path Goal
global PF PP MC
% global Motion
% global SenRGB SenDist SenGyro

% persistent w_sen
% if isempty(w_sen)
%     w_sen = 0;
% end

% persistent Flag_RecalculatePath
% if isempty(Flag_RecalculatePath)
%     Flag_RecalculatePath = 0;
% end


DEBUG = true;

if strcmp(PF.Estimate,'Searching')
    MC.ControlerState = 'LineTracking';

elseif strcmp(PF.Estimate, 'Working')
    if (PP.Flag_PathFound)
        MC.ControlerState = 'Point2Point';
    end
else
    if (DEBUG) fprintf('Robot STOP. \n'); end;
    error('Robot STOP. \n');
    MC.ControlerState = 'Stop';
end

switch MC.ControlerState
    case 'LineTracking'
        [T,v,w] = evalc('LineTracking();');
        MC.v = v;
        MC.w = w;
        
    case 'Point2Point'
        [v,w] = ContolerPosition(MC.w_old);
        MC.v = v;
        MC.w = w;
        MC.w_old = MC.w;
               
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
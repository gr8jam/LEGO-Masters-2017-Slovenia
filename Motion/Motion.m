function [v,w] = Motion(q)

global Robot Nodes
persistent w_sen
if isempty(w_sen)
    w_sen = 0;
end

DEBUG = true;

if strcmp(Robot.PF.Estimate,'Searching')
    MotionState = 'LineTracking';

elseif strcmp(Robot.PF.Estimate, 'Working')
    MotionState = 'Point2Point';
else
    if (DEBUG) fprintf('PF reinit complete. \n'); end;
    MotionState = 'Stop';
    
end

switch MotionState
    case 'LineTracking'
        [T,v,w] = evalc('LineTracking(Robot.q);');
        
    case 'Point2Point'
        q_sen = Robot.q;
        
        q_path = GetOptimalpath();
        q_ref = SwitchRefPos(q_sen, q_path);
        
        [v,w] = ContolerPosition(q_ref, q_sen, w_sen);
%         v = 40;
%         w = 0;
        w_sen = w;
        
        Robot.q_path = q_path;
        
%         if (DEBUG) fprintf('v = %4.2f \nw = %4.2f \n', v,w); end;
%         if (DEBUG) fprintf('x = %4.2f \ny = %4.2f \n\n', q_ref(1),q_ref(2)); end;
        
    case 'Stop'
        v = 0;
        w = 0;
        
    otherwise
        error('MotionState in unkonwn state. \n')
end

end
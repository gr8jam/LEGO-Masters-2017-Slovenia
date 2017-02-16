function [v,w] = Motion(q)

global Robot

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
        v = 10;
        w = 0;
        
    case 'Stop'
        v = 0;
        w = 0;
        
    otherwise
        error('MotionState in unkonwn state. \n')
end

end
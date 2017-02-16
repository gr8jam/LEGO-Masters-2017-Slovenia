function [v,w] = SimulateEV3(qTrue,i)
global Robot OdoRobot LocalizationState

if isempty(LocalizationState)
    LocalizationState = 'Init';
end

persistent first
if isempty(first)
    first = true;
end

DriverRGB();        % pero
DriverGyro();       % pero
DriverDist();       % pero

if (first)
    Robot = InitEV3(qTrue);
    first = false;
    v = 0;
    w = 0;
    fprintf('EV3 init complete \n')
else
    
    DEBUG = false;
    
    if i == 91+15
        if (DEBUG) fprintf('--- menjava na srednji pas ---'); end
        Robot.Motion.dkot = -70;
        Robot.Motion.SwitchRight = 3;
        Robot.Motion.Ptr = 10;
    end
    if i == 600+10
        if (DEBUG) fprintf('--- menjava na notranji pas ---'); end
        Robot.Motion.dkot = -45;
        Robot.Motion.SwitchRight = 3;
        Robot.Motion.Ptr = 10;
    end
    
    if i == 600+150+230
        if (DEBUG) fprintf('--- menjava na srednji pas ---'); end
        Robot.Motion.dkot = 45;
        Robot.Motion.SwitchLeft = 3;
        Robot.Motion.Ptr = 10;
    end
    if i == 600+150+230+250
        if (DEBUG) fprintf('--- menjava na zunanji pas ---'); end
        Robot.Motion.dkot = 35;
        Robot.Motion.SwitchLeft = 3;
        Robot.Motion.Ptr = 10;
    end
        
%     DriverRGB();        % pero
%     DriverGyro();       % pero
%     DriverDist();       % pero
    [v,w] = Motion(Robot.q);
    [Robot.q] = Localization(v,w);
end



end


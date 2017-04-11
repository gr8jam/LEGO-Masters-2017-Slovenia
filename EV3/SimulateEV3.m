function SimulateEV3(i)
global Robot


persistent first
if isempty(first)
    first = true;
end


if (first)
    Robot = InitEV3();
    first = false;
    fprintf('EV3 init complete \n')
else
    
%     DEBUG = false;
%     
%     if i == 91+15
%         if (DEBUG) fprintf('--- menjava na srednji pas ---'); end
%         Robot.Motion.dkot = -70;
%         Robot.Motion.SwitchRight = 3;
%         Robot.Motion.Ptr = 10;
%     end
%     if i == 600+10
%         if (DEBUG) fprintf('--- menjava na notranji pas ---'); end
%         Robot.Motion.dkot = -45;
%         Robot.Motion.SwitchRight = 3;
%         Robot.Motion.Ptr = 10;
%     end
%     
%     if i == 600+150+230
%         if (DEBUG) fprintf('--- menjava na srednji pas ---'); end
%         Robot.Motion.dkot = 45;
%         Robot.Motion.SwitchLeft = 3;
%         Robot.Motion.Ptr = 10;
%     end
%     if i == 600+150+230+250
%         if (DEBUG) fprintf('--- menjava na zunanji pas ---'); end
%         Robot.Motion.dkot = 35;
%         Robot.Motion.SwitchLeft = 3;
%         Robot.Motion.Ptr = 10;
%     end

    DriverRGB();      
    DriverGyro();
    DriverDist();
    
    task_Localization2();
    task_Localization();
    task_EnviromentDetection(i);
    task_PathPlanning();
    task_Controler();
    
    
end

SaveRobotGlobals();


end


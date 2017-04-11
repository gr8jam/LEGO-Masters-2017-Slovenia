function SwitchGoal()

global PP PF Nodes BF

persistent halfPath
if isempty(halfPath)
    halfPath = 0;
end

persistent oldGoal
if isempty(oldGoal)
    oldGoal = 0;
end


% persistent q_ref
% if isempty(q_ref)
%     x = Nodes(PP.Path(cntPath)).x;
%     y = Nodes(PP.Path(cntPath)).y;
%     
% end

%ClosestNodeIdx = GetClosestNode();
    
d_min = 45;

% if (abs(PP.xRef - PF.x) < d_min) && (abs(PP.yRef - PF.y) < d_min)
if ((PP.xRef - PF.x)^2 + (PP.yRef - PF.y)^2 < d_min^2)
    PP.cntPath = PP.cntPath + 1;
    
    
    PP.Goal = PP.Path(PP.lenPath - PP.cntPath);
    PP.xRef = Nodes(PP.Goal).x;
    PP.yRef = Nodes(PP.Goal).y;
    
    DEBUG = false;
    if (DEBUG) fprintf('path_idx = %d\n', PP.Path(PP.cntPath)); end;
    
    if (PP.cntPath >= PP.lenPath/2)
        PP.Flag_RecalculatePath = true;
    end
    
%     if (PP.cntPath >= PP.lenPath-1)
%         PP.Flag_RecalculatePath = true;
%     end
    
    if (oldGoal == 0)
        oldGoal = PP.Goal;
    end
    newTrack = ceil(PP.Goal/32);
    oldTrack = ceil(oldGoal/32);
    
    BF.Flag_NewMotion = true;
    switch oldTrack
        case 1
            switch newTrack
                case 1
                    BF.Flag_TurnLeft  = false;
                    BF.Flag_TurnRight = false;
                    BF.Flag_Forward  = true;
                case 2
                    BF.Flag_TurnLeft  = true;
                    BF.Flag_TurnRight = false;
                    BF.Flag_Forward  = false;
                case 3
                    BF.Flag_TurnLeft  = true;
                    BF.Flag_TurnRight = false;
                    BF.Flag_Forward  = false;
                otherwise
                    error('Check track index. \n')
            end
        case 2
            switch newTrack
                case 1
                    BF.Flag_TurnLeft  = false;
                    BF.Flag_TurnRight = true;
                    BF.Flag_Forward  = false;
                case 2
                    BF.Flag_TurnLeft  = false;
                    BF.Flag_TurnRight = false;
                    BF.Flag_Forward  = true;
                case 3
                    BF.Flag_TurnLeft  = true;
                    BF.Flag_TurnRight = false;
                    BF.Flag_Forward  = false;
                otherwise
                    error('Check track index. \n')
            end
        case 3
            switch newTrack
                case 1
                    BF.Flag_TurnLeft  = false;
                    BF.Flag_TurnRight = true;
                    BF.Flag_Forward  = false;
                case 2
                    BF.Flag_TurnLeft  = false;
                    BF.Flag_TurnRight = true;
                    BF.Flag_Forward  = false;
                case 3
                    BF.Flag_TurnLeft  = false;
                    BF.Flag_TurnRight = false;
                    BF.Flag_Forward  = true;
                otherwise
                    error('Check track index. \n')
            end
        otherwise
            error('Check track index. \n')
    end

    oldGoal = PP.Goal;



end


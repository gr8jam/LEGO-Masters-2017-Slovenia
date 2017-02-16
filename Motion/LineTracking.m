function [v,w] = LineTracking(q)

global Robot OdoRobot
DriverRGB();
Lokal = 0;

L = Robot.idxL;
D = Robot.idxR;
k = 0.75;

crna = 1;
bela = 2;

if Robot.Motion.SwitchLeft == 0 && Robot.Motion.SwitchRight == 0
    if L ~= crna && D ~= crna
        Robot.Motion.ww = 0; 
        Robot.Motion.vv = 100;
    elseif L == crna && D ~= crna
        Robot.Motion.ww = k;
        Robot.Motion.vv = 80;
    elseif L ~= crna && D == crna 
        Robot.Motion.ww = -k;
        Robot.Motion.vv = 80;
    else 
        Robot.Motion.vv = 40;
        Robot.Motion.ww = 0;
    end
end
%% ovira pred lokalizacijo
% if Robot.dist < 270 && Robot.Motion.Localisation == 0 && Robot.Motion.Odo == 0
%     Robot.Motion.Odo = 1;
%     OdoRobot = InitOdoEV3([0 0 0], Robot.Motion.vv,  Robot.Motion.ww);
% end
% if Robot.Motion.Odo == 1
%     [ Robot.Motion.vv,  Robot.Motion.ww] = OdoAroundObstacle(); 
% end
    
%% menjava pasu ven
if Robot.Motion.SwitchLeft == 3
    Robot.Motion.inc = 0;
    switch Robot.Motion.Ptr
        case 10                                 % zavijem desno proti notranjem pasu
           %dkot = -65; 
           Robot.q(3)
           Robot.Motion.rkot = wrapToPi(Robot.q(3) + Robot.Motion.dkot * pi / 180);
           Robot.Motion.rkot
           Robot.Motion.vv = 30;
           Robot.Motion.ww = (Robot.Motion.rkot - Robot.q(3)) * 2;
           1
           Robot.Motion.inc = 1;
        case 11
           Robot.Motion.vv = 30;
           Robot.Motion.ww = (Robot.Motion.rkot - Robot.q(3)) * 2;
           d = Robot.q(3) - Robot.Motion.rkot;
           d
           if abs(Robot.q(3) - Robot.Motion.rkot) < 0.2
            Robot.Motion.inc = 1;
            Robot.Motion.vv = 70;
            Robot.Motion.ww = 0;
            2
           end
           3
        case 12
            if L == bela && D == bela
               Robot.Motion.inc = 1; 
               Robot.Motion.vv = 70;
               12
            end
        case 13
            if  L == crna && D == crna
                41
               Robot.Motion.ww = -0.55;
               Robot.Motion.vv = 20;
               Robot.Motion.tDly = 0.066;
               Robot.Motion.Ptr = 15;
            elseif L ~= crna && D == crna
               Robot.Motion.ww = -0.55;
               Robot.Motion.vv = 60;
               Robot.Motion.Ptr = 0;
               Robot.Motion.SwitchLeft = 0;
               42
            elseif L == crna && D ~= crna
                Robot.Motion.Ptr = 20;
                Robot.Motion.ww = 0;
                Robot.Motion.vv = 55;
                43
            else
                77
            end
            
            13
        case 14
        case 15
            6
            if Robot.Motion.tDly == 0 || L ~= crna
              Robot.Motion.SwitchLeft = 0;
              Robot.Motion.Ptr = 0; 
              7
            end
        case 20
            if L ~= crna && D == crna
              Robot.Motion.SwitchLeft = 0;
              Robot.Motion.Ptr = 0;
              21
            elseif L ~= crna && D ~= crna
              Robot.Motion.SwitchLeft = 0;
              Robot.Motion.Ptr = 0;
              22
            elseif L == crna && D ~= crna
                if Robot.Motion.F_t == 0
                   Robot.Motion.F_t = 1; 
                   Robot.Motion.tDly = 0.066;
                end
                if Robot.Motion.F_t == 1 && Robot.Motion.tDly > 0
                   Robot.Motion.ww = -0.4;
                   Robot.Motion.SwitchLeft = 0;
                   Robot.Motion.Ptr = 0; 
                else
                   Robot.Motion.ww = -0.05;
                end
                23
            else
              Robot.Motion.ww = -0.3;
              Robot.Motion.vv = 30;
                24
            end
            20
        case 21
            
            
            
    end
end

%% menjava pasu noter

if Robot.Motion.SwitchRight == 3
    Robot.Motion.inc = 0;
    switch Robot.Motion.Ptr
        case 10                                 % zavijem desno proti notranjem pasu
           %dkot = -65; 
           Robot.q(3)
           Robot.Motion.rkot = wrapToPi(Robot.q(3) + Robot.Motion.dkot * pi / 180); 
           Robot.Motion.rkot
           Robot.Motion.vv = 30;
           Robot.Motion.ww = (Robot.Motion.rkot - Robot.q(3)) * 2;
           1
           Robot.Motion.inc = 1;
        case 11
           Robot.Motion.vv = 30;
           Robot.Motion.ww = (Robot.Motion.rkot - Robot.q(3)) * 2;
           d = Robot.q(3) - Robot.Motion.rkot;
           d
           if abs(Robot.q(3) - Robot.Motion.rkot) < 0.2
            Robot.Motion.inc = 1;
            Robot.Motion.vv = 70;
            Robot.Motion.ww = 0;
            2
           end
           3
        case 12
            if L == bela && D == bela
               Robot.Motion.inc = 1; 
               Robot.Motion.vv = 70;
               12
            end
        case 13
            if  L == crna && D == crna
                41
               Robot.Motion.ww = +0.55;
               Robot.Motion.vv = 20;
               Robot.Motion.tDly = 0.066;
               Robot.Motion.Ptr = 15;
            elseif L == crna && D ~= crna
               Robot.Motion.ww = +0.55;
               Robot.Motion.vv = 60;
               Robot.Motion.Ptr = 0;
               Robot.Motion.SwitchRight = 0;
               42
            elseif L ~= crna && D == crna
                Robot.Motion.Ptr = 20;
                Robot.Motion.vv = 55;
                43
            else
                77
            end
            
            13
        case 14
        case 15
            6
            if Robot.Motion.tDly == 0 || D ~= crna
              Robot.Motion.SwitchRight = 0;
              Robot.Motion.Ptr = 0; 
              7
            end
        case 20
            if L == crna && D ~= crna
              Robot.Motion.SwitchRight = 0;
              Robot.Motion.Ptr = 0;
              21
            elseif L ~= crna && D ~= crna
              Robot.Motion.SwitchRight = 0;
              Robot.Motion.Ptr = 0;
              22
            elseif L ~= crna && D == crna
                if Robot.Motion.F_t == 0
                   Robot.Motion.F_t = 1; 
                   Robot.Motion.tDly = 0.066;
                end
                if Robot.Motion.F_t == 1 && Robot.Motion.tDly > 0
                   Robot.Motion.ww = 0.4;
                   Robot.Motion.SwitchRight = 0;
                   Robot.Motion.Ptr = 0; 
                else
                   Robot.Motion.ww = 0.05;
                end
                23
            else
              Robot.Motion.ww = 0.3;
              Robot.Motion.vv = 30;
                24
            end
            20
        case 21
            
            
            
    end
    
end



% if Robot.Motion.SwitchRight == 2
%     if Robot.Motion.SwitchStart == 0
%         if Robot.q(3) < 0 
%             dkot = -75;
% 
%         else
%             dkot = -75;
%         end
%         Robot.Motion.rkot = wrapToPi(Robot.q(3) + dkot * pi / 180);
%         Robot.Motion.SwitchStart = 1;
%     end
%     vv = 150;
%     ww = (Robot.Motion.rkot - Robot.q(3)) * 2;
%     if abs(Robot.q(3) - Robot.Motion.rkot) < 0.03
%         Robot.Motion.SwitchRight = 1;
%         vv = 90;
%         ww = 0;
%     end
% end
% if Robot.Motion.SwitchRight == 1
%     vv = 90;
%     ww = 0;
%     if D == 17
%        Robot.Motion.tDly = 0.066;
%        Robot.Motion.sensD = 1;
%        vv = 90;
%        ww = 0.3;
%        1;
%     end
%     if Robot.Motion.sensD == 1 && Robot.Motion.tDly > 0 && L == 17
%        vv = 150;
%        ww = k;
%        Robot.Motion.sensD = 2;
%        2;
%     end
%     if Robot.Motion.sensD == 2 || Robot.Motion.tDly == 0
%        if D ~= 17
%           Robot.Motion.SwitchRight = 0;
%           Robot.Motion.SwitchStart = 0;
%           3;
%        end
%     end
%     
% end
%%
v = Robot.Motion.vv;
w = Robot.Motion.ww;


% 
% v = 50;
% w = 0;
%%
if Robot.Motion.inc == 1
    Robot.Motion.Ptr = Robot.Motion.Ptr + 1;
    Robot.Motion.F_Test = 0;
end
if Robot.Motion.F_Test == 0
   Robot.Motion.tiTest = 0.3 / 0.033;
end
%% timerji
if Robot.Motion.tiTest > 0
   Robot.Motion.tiTest = Robot.Motion.tiTest - 0.033; 
end
if Robot.Motion.tDly > 0
   Robot.Motion.tDly = Robot.Motion.tDly - 0.033;
end

end
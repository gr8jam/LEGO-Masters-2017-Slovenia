function [v,w] = LineTracking()

global PF MC OdoRobot SenRGB Robot
DriverRGB();
Lokal = 0;

Maxw = 0.8;
KP = 0.3;
KD = 0.15;
KI = 0.15;
MC.LF.offse = 24;
MC.LF.SENVAL = sum(sum(Robot.SenRGB.Left.ColorArray(:,:)-1));

L = SenRGB.Left.idx;
D = SenRGB.Right.idx;

k = 0.75;

crna = 1;
bela = 2;
if MC.LF.SwitchLeft == 0 && MC.LF.SwitchRight == 0
    MC.LF.err = MC.LF.SENVAL - MC.LF.offse;
    MC.LF.integ = MC.LF.integ + MC.LF.err * KI;
    MC.LF.deriv = MC.LF.err - MC.LF.olderr;

    if (MC.LF.integ < -Maxw) 
        MC.LF.integ = -Maxw; 
    end
    if (MC.LF.integ > Maxw)  
        MC.LF.integ =  Maxw; 
    end

    MC.LF.Turn = KP * MC.LF.err + MC.LF.integ + MC.LF.deriv * KD;

    if (MC.LF.Turn < -Maxw) 
        MC.LF.Turn = -Maxw; 
    end
    if (MC.LF.Turn > Maxw)  
        MC.LF.Turn =  Maxw; 
    end
    MC.LF.olderr = MC.LF.err;
    
    MC.LF.ww = -MC.LF.Turn; 
    MC.LF.vv = 160;
end

% if MC.LF.SwitchLeft == 0 && MC.LF.SwitchRight == 0
%     if L ~= crna && D ~= crna
%         MC.LF.ww = 0; 
%         MC.LF.vv = 100;
%     elseif L == crna && D ~= crna
%         MC.LF.ww = k;
%         MC.LF.vv = 80;
%     elseif L ~= crna && D == crna 
%         MC.LF.ww = -k;
%         MC.LF.vv = 80;
%     else 
%         MC.LF.vv = 40;
%         MC.LF.ww = 0;
%     end
% end
%% ovira pred lokalizacijo
% if Robot.dist < 270 && MC.LF.Localisation == 0 && MC.LF.Odo == 0
%     MC.LF.Odo = 1;
%     OdoRobot = InitOdoEV3([0 0 0], MC.LF.vv,  MC.LF.ww);
% end
% if MC.LF.Odo == 1
%     [ MC.LF.vv,  MC.LF.ww] = OdoAroundObstacle(); 
% end
    
%% menjava pasu ven
if MC.LF.SwitchLeft == 3
    MC.LF.inc = 0;
    switch MC.LF.Ptr
        case 10                                 % zavijem desno proti notranjem pasu
           %dkot = -65; 
           PF.fi
           MC.LF.rkot = wrapToPi(PF.fi + MC.LF.dkot * pi / 180);
           MC.LF.rkot
           MC.LF.vv = 30;
           MC.LF.ww = (MC.LF.rkot - PF.fi) * 2;
           1
           MC.LF.inc = 1;
        case 11
           MC.LF.vv = 30;
           MC.LF.ww = (MC.LF.rkot - PF.fi) * 2;
           d = PF.fi - MC.LF.rkot;
           d
           if abs(PF.fi - MC.LF.rkot) < 0.2
            MC.LF.inc = 1;
            MC.LF.vv = 70;
            MC.LF.ww = 0;
            2
           end
           3
        case 12
            if L == bela && D == bela
               MC.LF.inc = 1; 
               MC.LF.vv = 70;
               12
            end
        case 13
            if  L == crna && D == crna
                41
               MC.LF.ww = -0.55;
               MC.LF.vv = 20;
               MC.LF.tDly = 0.066;
               MC.LF.Ptr = 15;
            elseif L ~= crna && D == crna
               MC.LF.ww = -0.55;
               MC.LF.vv = 60;
               MC.LF.Ptr = 0;
               MC.LF.SwitchLeft = 0;
               42
            elseif L == crna && D ~= crna
                MC.LF.Ptr = 20;
                MC.LF.ww = 0;
                MC.LF.vv = 55;
                43
            else
                77
            end
            
            13
        case 14
        case 15
            6
            if MC.LF.tDly == 0 || L ~= crna
              MC.LF.SwitchLeft = 0;
              MC.LF.Ptr = 0; 
              7
            end
        case 20
            if L ~= crna && D == crna
              MC.LF.SwitchLeft = 0;
              MC.LF.Ptr = 0;
              21
            elseif L ~= crna && D ~= crna
              MC.LF.SwitchLeft = 0;
              MC.LF.Ptr = 0;
              22
            elseif L == crna && D ~= crna
                if MC.LF.F_t == 0
                   MC.LF.F_t = 1; 
                   MC.LF.tDly = 0.066;
                end
                if MC.LF.F_t == 1 && MC.LF.tDly > 0
                   MC.LF.ww = -0.4;
                   MC.LF.SwitchLeft = 0;
                   MC.LF.Ptr = 0; 
                else
                   MC.LF.ww = -0.05;
                end
                23
            else
              MC.LF.ww = -0.3;
              MC.LF.vv = 30;
                24
            end
            20
        case 21
            
            
            
    end
end

%% menjava pasu noter

if MC.LF.SwitchRight == 3
    MC.LF.inc = 0;
    switch MC.LF.Ptr
        case 10                                 % zavijem desno proti notranjem pasu
           %dkot = -65; 
           PF.fi
           MC.LF.rkot = wrapToPi(PF.fi + MC.LF.dkot * pi / 180); 
           MC.LF.rkot
           MC.LF.vv = 30;
           MC.LF.ww = (MC.LF.rkot - PF.fi) * 2;
           1
           MC.LF.inc = 1;
        case 11
           MC.LF.vv = 30;
           MC.LF.ww = (MC.LF.rkot - PF.fi) * 2;
           d = PF.fi - MC.LF.rkot;
           d
           if abs(PF.fi - MC.LF.rkot) < 0.2
            MC.LF.inc = 1;
            MC.LF.vv = 70;
            MC.LF.ww = 0;
            2
           end
           3
        case 12
            if L == bela && D == bela
               MC.LF.inc = 1; 
               MC.LF.vv = 70;
               12
            end
        case 13
            if  L == crna && D == crna
                41
               MC.LF.ww = +0.55;
               MC.LF.vv = 20;
               MC.LF.tDly = 0.066;
               MC.LF.Ptr = 15;
            elseif L == crna && D ~= crna
               MC.LF.ww = +0.55;
               MC.LF.vv = 60;
               MC.LF.Ptr = 0;
               MC.LF.SwitchRight = 0;
               42
            elseif L ~= crna && D == crna
                MC.LF.Ptr = 20;
                MC.LF.vv = 55;
                43
            else
                77
            end
            
            13
        case 14
        case 15
            6
            if MC.LF.tDly == 0 || D ~= crna
              MC.LF.SwitchRight = 0;
              MC.LF.Ptr = 0; 
              7
            end
        case 20
            if L == crna && D ~= crna
              MC.LF.SwitchRight = 0;
              MC.LF.Ptr = 0;
              21
            elseif L ~= crna && D ~= crna
              MC.LF.SwitchRight = 0;
              MC.LF.Ptr = 0;
              22
            elseif L ~= crna && D == crna
                if MC.LF.F_t == 0
                   MC.LF.F_t = 1; 
                   MC.LF.tDly = 0.066;
                end
                if MC.LF.F_t == 1 && MC.LF.tDly > 0
                   MC.LF.ww = 0.4;
                   MC.LF.SwitchRight = 0;
                   MC.LF.Ptr = 0; 
                else
                   MC.LF.ww = 0.05;
                end
                23
            else
              MC.LF.ww = 0.3;
              MC.LF.vv = 30;
                24
            end
            20
        case 21
            
            
            
    end
    
end



% if MC.LF.SwitchRight == 2
%     if MC.LF.SwitchStart == 0
%         if PF.fi < 0 
%             dkot = -75;
% 
%         else
%             dkot = -75;
%         end
%         MC.LF.rkot = wrapToPi(PF.fi + dkot * pi / 180);
%         MC.LF.SwitchStart = 1;
%     end
%     vv = 150;
%     ww = (MC.LF.rkot - PF.fi) * 2;
%     if abs(PF.fi - MC.LF.rkot) < 0.03
%         MC.LF.SwitchRight = 1;
%         vv = 90;
%         ww = 0;
%     end
% end
% if MC.LF.SwitchRight == 1
%     vv = 90;
%     ww = 0;
%     if D == 17
%        MC.LF.tDly = 0.066;
%        MC.LF.sensD = 1;
%        vv = 90;
%        ww = 0.3;
%        1;
%     end
%     if MC.LF.sensD == 1 && MC.LF.tDly > 0 && L == 17
%        vv = 150;
%        ww = k;
%        MC.LF.sensD = 2;
%        2;
%     end
%     if MC.LF.sensD == 2 || MC.LF.tDly == 0
%        if D ~= 17
%           MC.LF.SwitchRight = 0;
%           MC.LF.SwitchStart = 0;
%           3;
%        end
%     end
%     
% end
%%
v = MC.LF.vv;
w = MC.LF.ww;


% 
% v = 50;
% w = 0;
%%
if MC.LF.inc == 1
    MC.LF.Ptr = MC.LF.Ptr + 1;
    MC.LF.F_Test = 0;
end
if MC.LF.F_Test == 0
   MC.LF.tiTest = 0.3 / 0.033;
end
%% timerji
if MC.LF.tiTest > 0
   MC.LF.tiTest = MC.LF.tiTest - 0.033; 
end
if MC.LF.tDly > 0
   MC.LF.tDly = MC.LF.tDly - 0.033;
end

end
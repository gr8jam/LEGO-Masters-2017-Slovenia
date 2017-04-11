function DriverRGB()
global TrueRobot 
global SenRGB

for i = -3:1:3
    x = TrueRobot.q(1) + i;
    for j = -3:1:3
        y = TrueRobot.q(2) + j;
        fi = TrueRobot.q(3);
        [idxL,idxR, posL, posR] = SimulationRGB(x,y,fi);
        
        SenRGB.Left.ColorArray(7-(3+j), 4+i) = idxL;
        SenRGB.Right.ColorArray(7-(3+j), 4+i) = idxR;
    end
end


[idxL,idxR, posL, posR] = SimulationRGB(TrueRobot.q(1), TrueRobot.q(2), TrueRobot.q(3));

bool = (SenRGB.Left.ColorArray ~= idxL);
SenRGB.Left.Valid = (sum(sum(bool)) == 0);

bool = (SenRGB.Right.ColorArray ~= idxR);
SenRGB.Right.Valid = (sum(sum(bool)) == 0);

if SenRGB.Left.Valid
    if (SenRGB.Left.idx ~= idxL)
        SenRGB.Left.Changed = true;
        SenRGB.Left.idx = idxL;
    else
        SenRGB.Left.Changed = false;
    end
end

if SenRGB.Right.Valid
    if (SenRGB.Right.idx ~= idxR)
        SenRGB.Right.Changed = true;
        SenRGB.Right.idx = idxR;
    %     fprintf('Color CHANGED \n')
    else
        SenRGB.Right.Changed = false;
    end
end

% Robot.hsvL = BarvnaLestvicaHSV(idxL);
% Robot.hsvR = BarvnaLestvicaHSV(idxR);
% 
% Robot.idxL = idxL;
% Robot.idxR = idxR;
% 
% Robot.posL = posL;
% Robot.posR = posR;


SenRGB.Left.x = posL(1);
SenRGB.Left.y = posL(2);


SenRGB.Right.x = posR(1);
SenRGB.Right.y = posR(2);


ColorChangeFilter();

end


function ColorChangeFilter()
global SenRGB

persistent ColorIdxR_old
if isempty(ColorIdxR_old)
    ColorIdxR_old = 1;
end

persistent ColorIdxL_old
if isempty(ColorIdxL_old)
    ColorIdxL_old = 1;
end

persistent cntRight
if isempty(cntRight)
    cntRight = 1;
end

persistent cntLeft
if isempty(cntLeft)
    cntLeft = 0;
end

SenRGB.Right.ChangedFil = false;
if (SenRGB.Right.Valid)
    if (SenRGB.Right.idx == ColorIdxR_old) && (SenRGB.Right.idx ~= SenRGB.Right.idxFil)
        cntRight = cntRight + 1;
        if (cntRight > 3)
            SenRGB.Right.ChangedFil = true;
            SenRGB.Right.idxFil = SenRGB.Right.idx;
        end
    else
        cntRight = 0;        
    end
    
    ColorIdxR_old = SenRGB.Right.idx;
end

SenRGB.Left.ChangedFil = false;
if (SenRGB.Left.Valid)
    if (SenRGB.Left.idx == ColorIdxL_old) && (SenRGB.Left.idx ~= SenRGB.Left.idxFil)
        cntLeft = cntLeft + 1;
        if (cntLeft > 3)
            SenRGB.Left.ChangedFil = true;
            SenRGB.Left.idxFil = SenRGB.Left.idx;
        end
    else
        cntLeft = 0;        
    end
    
    ColorIdxL_old = SenRGB.Right.idx;
end




end


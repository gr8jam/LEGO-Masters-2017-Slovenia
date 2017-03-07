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

if (SenRGB.Left.idx ~= idxL)
    SenRGB.Left.Changed = true;
else
    SenRGB.Left.Changed = false;
end
if (SenRGB.Right.idx ~= idxR)
    SenRGB.Right.Changed = true;
%     fprintf('Color CHANGED \n')
else
    SenRGB.Right.Changed = false;
end

% Robot.hsvL = BarvnaLestvicaHSV(idxL);
% Robot.hsvR = BarvnaLestvicaHSV(idxR);
% 
% Robot.idxL = idxL;
% Robot.idxR = idxR;
% 
% Robot.posL = posL;
% Robot.posR = posR;

SenRGB.Left.idx = idxL;
SenRGB.Left.x = posL(1);
SenRGB.Left.y = posL(2);

SenRGB.Right.idx = idxR;
SenRGB.Right.x = posR(1);
SenRGB.Right.y = posR(2);



end


function DriverRGB()
global TrueRobot Robot
global BarvnaLestvicaHSV  % BarvnaLestvicaRGB
global SenRGB

[idxL,idxR, posL, posR] = SimulationRGB(TrueRobot.q(1), TrueRobot.q(2), TrueRobot.q(3));

Robot.hsvL = BarvnaLestvicaHSV(idxL);
Robot.hsvR = BarvnaLestvicaHSV(idxR);

Robot.idxL = idxL;
Robot.idxR = idxR;

Robot.posL = posL;
Robot.posR = posR;

SenRGB.Left.idx = idxL;
SenRGB.Left.x = posL(1);
SenRGB.Left.y = posL(2);

SenRGB.Right.idx = idxR;
SenRGB.Right.x = posR(1);
SenRGB.Right.y = posR(2);


end


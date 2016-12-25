function DriverRGB()
global TrueRobot Robot
global BarvnaLestvicaHSV  BarvnaLestvicaRGB hhh

[idxL,idxR, posL, posR] = SimulationRGB(TrueRobot.q);


Robot.hsvL = BarvnaLestvicaHSV(idxL);
Robot.hsvR = BarvnaLestvicaHSV(idxR);

Robot.idxL = idxL;
Robot.idxR = idxR;

Robot.posL = posL;
Robot.posR = posR;

set(hhh(8),'Color',  BarvnaLestvicaRGB(idxL,:)/255);
set(hhh(9),'Color',  BarvnaLestvicaRGB(idxR,:)/255);


end
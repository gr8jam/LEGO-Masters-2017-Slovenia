function DriverGyro()
global TrueRobot Robot

Robot.fi = normrnd(0 , 0.09) + SimulationGyro(TrueRobot.q);

end


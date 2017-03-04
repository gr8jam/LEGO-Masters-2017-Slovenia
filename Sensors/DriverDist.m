function DriverDist()
global TrueRobot Robot
global TrueWalls TrueObstacles 

Robot.dist = SimulationDist(TrueRobot.q, TrueWalls, TrueObstacles);

end


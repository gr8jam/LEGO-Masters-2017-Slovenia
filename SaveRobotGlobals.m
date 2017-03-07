function SaveRobotGlobals()
global Robot

global Walls WallsKeepOut
global ObstaclesCenters Obstacles ObstaclesKeepOut
global DistanceKeepOut_Obstacles
global NodeConnectionDistanceMax NodeConnectionAngleLimit
global Nodes Path Goal
global PF PP MC
% global Motion
global SenRGB SenDist SenGyro
global v w

Robot.Walls = Walls;
Robot.WallsKeepOut = WallsKeepOut;
Robot.ObstaclesCenters = ObstaclesCenters;
Robot.Obstacles = Obstacles;
Robot.ObstaclesKeepOut = ObstaclesKeepOut;
Robot.DistanceKeepOut_Obstacles = DistanceKeepOut_Obstacles;
Robot.NodeConnectionDistanceMax = NodeConnectionDistanceMax;
Robot.NodeConnectionAngleLimit = NodeConnectionAngleLimit;
Robot.Nodes = Nodes;
Robot.Path = Path;
Robot.Goal = Goal;
Robot.PF = PF;
Robot.PP = PP;
Robot.MC = MC;
% Robot.Motion = Motion;
Robot.SenRGB = SenRGB;
Robot.SenDist = SenDist;
Robot.SenGyro = SenGyro;
Robot.v = v;
Robot.w = w;

end

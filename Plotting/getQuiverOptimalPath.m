function [xx,yy,uu,vv] = getQuiverOptimalPath()

global Nodes Robot

xx = [];
yy = [];
uu = [];
vv = [];

for idx = (Robot.PP.lenPath):-1:2
%     if (Robot.Path(idx) == 0)
%         break;
%     end
    
    x = Nodes(Robot.PP.Path(idx)).x;
    y = Nodes(Robot.PP.Path(idx)).y;
    
    u = Nodes(Robot.PP.Path(idx-1)).x - Nodes(Robot.PP.Path(idx)).x;
    v = Nodes(Robot.PP.Path(idx-1)).y - Nodes(Robot.PP.Path(idx)).y;
    
    xx = [xx x];
    yy = [yy y];
    uu = [uu u];
    vv = [vv v];
end


end

function [xx,yy,uu,vv] = getQuiverOptimalPath(Path)

global Nodes

xx = [];
yy = [];
uu = [];
vv = [];

for idx = 1:length(Path)-1
    if (Path(idx) == 0)
        break;
    end
    
    x = Nodes(Path(idx)).x;
    y = Nodes(Path(idx)).y;
    
    u = Nodes(Path(idx+1)).x - Nodes(Path(idx)).x;
    v = Nodes(Path(idx+1)).y - Nodes(Path(idx)).y;
    
    xx = [xx x];
    yy = [yy y];
    uu = [uu u];
    vv = [vv v];
end


end

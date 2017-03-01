function [x,y,u,v] = getQuiverOptimalPath(OptimalPath)

x = [];
y = [];
u = [];
v = [];

for i = 1:size(OptimalPath,2)-1
    x = [x OptimalPath(1,i)];
    y = [y OptimalPath(2,i)];
    u = [u OptimalPath(1,i+1)-OptimalPath(1,i)];
    v = [v OptimalPath(2,i+1)-OptimalPath(2,i)];
end


end

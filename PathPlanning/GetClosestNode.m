function ClosestNodeIdx = GetClosestNode()
global PF Nodes

distOld = 99999;
ClosestNodeIdx = 0;

for i = 1:96
    %% TODO: check if on a valid list
    
    %%
    
    dist = sqrt((Nodes(i).x - PF.x)^2 + (Nodes(i).y - PF.y)^2);
    
    if i > 90
        a = 0;
    end
    if dist < distOld
        distOld = dist;
        ClosestNodeIdx = i;
    end
    
end
        
end

function ComputeNodesColors()
global Nodes

for i = 1:96
    x = Nodes(i).x;
    y = Nodes(i).y;
    fi = Nodes(i).fi;
    
    [idxL, idxR, posL, posR] = SimulationRGB(x,y,fi);
    
    Nodes(i).idxColor = idxR;

    Nodes(i).mtcColor = 0;
end

end

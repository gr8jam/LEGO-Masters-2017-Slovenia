function DrawOptimalPathDijkstra(fig, Nodes, OptimalPath, delay)

figure(fig)
hold on;

for i = 1:length(OptimalPath)-1
    CurrIdx = OptimalPath(i);
    xs = Nodes(CurrIdx).x;
    ys = Nodes(CurrIdx).y;
    
    NextIdx = OptimalPath(i+1);
    xe = Nodes(NextIdx).x;
    ye = Nodes(NextIdx).y;
      
    [x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,pi/6,35);
    
    plot([xs xe x_arrow],[ys ye y_arrow],'k-','LineWidth', 2.5);
%     quiver(xs,ys,xe-xs,ye-ys,'r-','LineWidth', 2);
    pause(delay);
end

end
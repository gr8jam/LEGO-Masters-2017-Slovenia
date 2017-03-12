function DrawOptimalPathDijkstra(fig, Nodes, PP, delay)

figure(fig)
hold on;

for j = 2:(PP.lenPath)
    i = j;
% for i = (PP.lenPath):-1:2
% for i = 1:length(OptimalPath)-1
    CurrIdx = PP.Path(i);
    xs = Nodes(CurrIdx).x;
    ys = Nodes(CurrIdx).y;
    
    NextIdx = PP.Path(i-1);
    xe = Nodes(NextIdx).x;
    ye = Nodes(NextIdx).y;
      
    [x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,pi/6,55);
       
    
    Color = [0 164 58]/255;     % green
    Color = [0 218 58]/255;     % green
    Color = [255, 110, 0]/255;  % orange
    
%     Color = [255 0 102]/255;  % pink
    
    Color = 'c';

    plot([xs xe x_arrow],[ys ye y_arrow],'Color',Color,'LineWidth', 3);
    
%     quiver(xs,ys,xe-xs,ye-ys,'r-','LineWidth', 2);
%     pause(delay);

    if (j == PP.lenPath)
        Color = 'g';
    else
        Color = 'b';
        plot(xs,ys,'.','Color',Color,'MarkerSize',35)
    end
    

end


% for i = (PP.lenPath):-1:2
% % for i = 1:length(OptimalPath)-1
%     NextIdx = PP.Path(i-1);
%     xe = Nodes(NextIdx).x;
%     ye = Nodes(NextIdx).y;
% 
%     Color = 'b';
%     plot(xe,ye,'.','Color',Color,'MarkerSize',15)
% end

end
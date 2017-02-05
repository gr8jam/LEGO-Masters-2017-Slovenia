function DrawWalls(fig, Walls)

figure(fig);
hold on;
if ~isempty(Walls)
    for i=1:size(Walls,1)
       line(Walls(i,[1,3]),Walls(i,[2,4]),'LineWidth',7,'Color',[0.86 0.74 0.55]); 
    end
end


end
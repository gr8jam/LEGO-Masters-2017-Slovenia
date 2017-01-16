function DrawNodesPositions(fig, Nodes, delay)
figure(fig)
hold on;
for i = 1:length(Nodes)
    plot(Nodes(i).x,Nodes(i).y,'b.','MarkerSize',25)
    pause(delay);
end

end
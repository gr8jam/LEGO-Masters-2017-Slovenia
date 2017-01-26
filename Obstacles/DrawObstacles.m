function DrawObstacles(fig, Obstacles)

figure(fig);
hold on;
if ~isempty(Obstacles)
    for i=1:size(Obstacles,1)
       line(Obstacles(i,[1,3]),Obstacles(i,[2,4]),'LineWidth',7,'Color',[0.86 0.74 0.55]); 
    end
end
load('SrediscaOvir.mat')
ang = 0:0.1745:2*pi;
R = 50;
color = [ 0.7 0.7 0.7];
for i=1:length(x)
    xd = R * cos(ang) + x(i);
    yd = R * sin(ang) + y(i);
    plot(xd,   yd,   '-', 'Color', color,'LineWidth',4);
    plot(x(i), y(i), '.', 'Color', color,'MarkerSize',90);
end

end
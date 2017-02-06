function DrawObstacles(fig, Obstacles)

figure(fig);
hold on;

ang = 0:0.01:2*pi+0.01;
R = 50 - 4;

color = [ 0.7 0.7 0.7];

for i=1:size(Obstacles,1)
    xo = R * cos(ang) + Obstacles(i,1);
    yo = R * sin(ang) + Obstacles(i,2);
    plot(xo,   yo,   '-', 'Color', color,'LineWidth',4);
    plot(Obstacles(i,1), Obstacles(i,2), '.', 'Color', color,'MarkerSize',70);
end

end
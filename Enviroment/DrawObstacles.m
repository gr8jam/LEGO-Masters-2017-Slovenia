function DrawObstacles(fig, ObstacleCenters)

figure(fig);
hold on;

ang = 0:0.01:2*pi+0.01;
R = 50 - 0;

color = [ 0.7 0.7 0.7];

for i=1:size(ObstacleCenters,1)
    xo = R * cos(ang) + ObstacleCenters(i,1);
    yo = R * sin(ang) + ObstacleCenters(i,2);
    plot(ObstacleCenters(i,1), ObstacleCenters(i,2), '.', 'Color', color,'MarkerSize',75);
    plot(xo, yo,   '-', 'Color', 'k','LineWidth',1.2);
    plot(ObstacleCenters(i,1), ObstacleCenters(i,2), 'k+', 'MarkerSize',20);
    
end

end
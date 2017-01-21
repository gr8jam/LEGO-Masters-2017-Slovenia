function DrawPolygonMapColors(fig,colorMap)

global PolygonMapColors

figure(fig)
axis equal
hold on;
xGrid = repmat(1:2500,1800,1);
yGrid = repmat(1:1800,1,2500);
[m,n] = size(colorMap);
for idx = m:-1:1
    bool = (PolygonMapColors == idx);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', colorMap(idx,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);
end

end


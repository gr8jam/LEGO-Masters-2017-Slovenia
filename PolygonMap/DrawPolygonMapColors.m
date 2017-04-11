function DrawPolygonMapColors(fig,PolygonMap,ColorMap)

figure(fig)
hold on;

xGrid = repmat(1:2500,1800,1);
yGrid = repmat(1:1800,1,2500);
[m,n] = size(ColorMap);
for idx = m:-1:1
    bool = (PolygonMap == idx);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', ColorMap(idx,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);
end

end


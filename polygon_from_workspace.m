clear all;
close all;

load('Polygon_map')



%% Choose colorMap
% colorMap = colorMap_Original;
colorMap = colorMap_Pastel;

%% Draw polygon

figure
% figure('Position', [1550 100 40*35 20*35])
hold on

for i = 1:length(colorMap)
    bool = (colors == i-1);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', colorMap(i,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);
end






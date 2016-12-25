clear all;
load('PolygonColorData.mat')

%% izris polygona
figure
hold on
colorMap = BarvnaLestvicaRGB/255;
for idx = 1:length(BarvnaLestvicaRGB)
    bool = (PolygonMapColors == idx);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', colorMap(idx,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);
end
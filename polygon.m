close all;
clear all;

xLen = 400;
yLen = 400;

Grid = zeros(xLen,yLen,3);

xGrid = linspace(-1250,1250,xLen);
% xGrid = linspace(-100,700,xLen);
xGrid = repmat(xGrid, yLen ,1);

yGrid = linspace(-900,900,xLen)';
% yGrid = linspace(-10,800,xLen)';
yGrid = repmat(yGrid, 1, xLen);

% colors = 98 * ones(xLen,yLen);
% colors(40:60, 60:90) = 114;


colors = zeros(xLen,yLen);
for ix = 1:xLen
    for iy = 1:yLen
        x = xGrid(1,ix);
        y = yGrid(iy,1);
        
        if (abs(x-134)<4) && (abs(y+435.5)<4)
            xo = x;
            yo = y;           
        end
        colors(iy,ix) = RGBsensorModel(x,y);
    end
end


Grid(:,:,1) = xGrid;
Grid(:,:,2) = yGrid;
Grid(:,:,3) = colors;




% figure
figure('Position', [1550 100 40*35 20*35])
colorSign = 'w';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorSign, 'Marker', '.', 'LineStyle', 'none');
hold on

colorSign = 'k';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorSign, 'Marker', '.', 'LineStyle', 'none');

colorSign = 'r';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorSign, 'Marker', '.', 'LineStyle', 'none');

colorSign = 'g';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorSign, 'Marker', '.', 'LineStyle', 'none');

colorSign = 'b';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorSign, 'Marker', '.', 'LineStyle', 'none');

colorSign = 'y';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorSign, 'Marker', '.', 'LineStyle', 'none');

colorSign = 'm';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', [204,51,0]./255, 'Marker', '.', 'LineStyle', 'none');

colorSign = 'c';
bool = Grid(:,:,3) == colorSign;
xDraw = xGrid(bool);
yDraw = yGrid(bool);
plot(xDraw, yDraw, 'Color', colorSign, 'Marker', '.', 'LineStyle', 'none');

plot(xo, yo, 'c+', 'MarkerSize',3.75);

% A = [ 625 ;  275];
% plot(A(1), A(2), 'b+', 'MarkerSize',3.75)
% 
% J = [  -99;  640];
% K = [  165;    0];
% kJK = (J(2)-K(2))/(J(1)-K(1));
% 
% P = A;
% theta1 = atan(kJK) + pi;
% P_ = P + 15 .* [cos(theta1); sin(theta1)]; 
% 
% k= tan(P_(2)/P_(1));
% x = 350:2:700;
% y = k.*(x-A(1)) + A(2);
% 
% plot(x, y, 'g-', 'MarkerSize',3.75)
% 
% x = 400:2:700;
% y = (-1/k) .*(x-A(1)) + A(2);
% plot(x, y, 'g-', 'MarkerSize',3.75)

% plot(Grid(:,:,1), Grid(:,:,2), 'Color', char(Grid(:,:,3)), 'Marker', '.', 'LineStyle', 'none');
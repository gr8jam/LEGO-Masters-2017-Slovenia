clear all;
close all;

load('PolygonColorData');

% PolygonMapColors = im_new;
% BarvnaLestvicaRGB = colorMap_new;
% BarvnaLestvicaHSV = rgb2hsv(BarvnaLestvicaRGB);


% BarvnaLestvicaHSV_pastel = 

% fig = figure;
% set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
% hold on
% for i = length(BarvnaLestvicaRGB):-1:1
%     bool = (im_new == i);
%     xDraw = xGrid(bool);
%     yDraw = yGrid(bool);
%     plot(xDraw, yDraw, 'Color', BarvnaLestvicaRGB(i,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);  
% end

%%
black  = [hex2dec('00') hex2dec('00') hex2dec('00')];
white  = [hex2dec('FF') hex2dec('FF') hex2dec('FF')];
red    = [hex2dec('FF') hex2dec('00') hex2dec('00')];
yellow = [hex2dec('EE') hex2dec('CC') hex2dec('00')];
green  = [hex2dec('00') hex2dec('FF') hex2dec('00')];
blue   = [hex2dec('00') hex2dec('FF') hex2dec('FF')];
brown  = [hex2dec('A0') hex2dec('5A') hex2dec('2C')];

BarvnaLestvicaRGB = [black; white; red; yellow; green; blue; brown] / 255;
BarvnaLestvicaHSV = rgb2hsv(BarvnaLestvicaRGB);

BarvnaLestvicaHSV_pastel = BarvnaLestvicaHSV;
BarvnaLestvicaHSV_pastel(:,2) = BarvnaLestvicaHSV_pastel(:,2) .* 0.3; %BarvnaLestvicaHSV_pastel(:,2)
BarvnaLestvicaRGB_pastel = hsv2rgb(BarvnaLestvicaHSV_pastel);
BarvnaLestvicaRGB_pastel(1,:) = [0 0 0] + 0.6;

fig = figure;
set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on
for i = length(BarvnaLestvicaRGB_pastel):-1:1
    bool = (PolygonMapColors == i);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', BarvnaLestvicaRGB_pastel(i,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);  
end

BarvnaLestvicaRGB = [black; white; red; yellow; green; blue; brown];

%%

save('PolygonColorData','BarvnaLestvicaRGB',...
     'BarvnaLestvicaHSV','xGrid','yGrid',...
     'BarvnaLestvicaRGB_pastel', 'PolygonMapColors');
 
 clear all;
 load('PolygonColorData');
 
 
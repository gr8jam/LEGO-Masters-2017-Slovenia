% Lestvica = imread('BarvnaLestvica.png');
% slika = imread('Podlaga04.png');
% load('BarvnaLestvica.mat');
% load('HSVBarvnaLestvica.mat');

% save('Barve.mat','HSVBarvnaLestvica','BarvnaLestvica','xGrid','yGrid','proga','slika')
load('Barve.mat')



%% po HSV
indeksmapaHSV = uint8(zeros(1800,2500));
for idx = 1:length(HSVBarvnaLestvica)
    
    index1 = (proga(:,:,1) == HSVBarvnaLestvica(idx,1));
    index2 = (proga(:,:,2) == HSVBarvnaLestvica(idx,2));
    index3 = (proga(:,:,3) == HSVBarvnaLestvica(idx,3));

    index = index1 & index2 & index3;

    indeksmapaHSV(index) = idx;             % indeksiram barve

end
% popravim prehodne barve
index2 = (proga(:,:,2) < 0.9);
index3 = (proga(:,:,3) < 0.85);
index = index2 & index3;

indeksmapaHSV(index) = 17;                  % dodam èrno

indeksmapaHSV(indeksmapaHSV == 0) = 17;     % vse kar je ostalo naj bo èrno

%% izris
figure
hold on
colorMap = BarvnaLestvica/255;
for i = 1:length(BarvnaLestvica)
    bool = (indeksmapaHSV == i);
    xDraw = xGrid(bool);
    yDraw = yGrid(bool);
    plot(xDraw, yDraw, 'Color', colorMap(i,:), 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 1);
end

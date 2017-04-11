function InitGrafic_FigRGB()
global hFigRGB

FigRGB = figure(); 
clf;

screensize = get( groot, 'Screensize' );
W_screen = screensize(3);
H_screen = screensize(4);
W = W_screen/2;
H = 0.4 * W;
set(FigRGB, 'Position', [0 H_screen-H-100 W H]);
% set(FigRGB, 'Position', [W 0 W H]); 


subplot(2,2,1);
title('Left RGB sensor ColorArray ')
hold on;
hFigRGB.arrayL = zeros(7,7);
for i = -3:1:3
    for j = -3:1:3
        hFigRGB.arrayL(4-j,4-i) = rectangle('Position',[i-0.5,j-0.5,1,1]);
    end
end
axis([-4 4 -4 4])
axis equal;

subplot(2,2,2);
title('Right RGB sensor ColorArray ')
hold on;
hFigRGB.arrayR = zeros(7,7);
for i = -3:1:3
    for j = -3:1:3
        hFigRGB.arrayR(4-j,4-i) = rectangle('Position',[i-0.5,j-0.5,1,1]);
    end
end
axis([-4 4 -4 4])
axis equal;

subplot(2,2,3);
title('StackLastColors ')
hold on;
hFigRGB.StackL = zeros(5,1);
for i = 1:length(hFigRGB.StackL)
    hFigRGB.StackL(i) = rectangle('Position',[0,-i,1,1]);
end
axis([0 1 -5 0])

subplot(2,2,4);
title('StackLastColors ')
hold on;
hFigRGB.StackR = zeros(5,1);
for i = 1:length(hFigRGB.StackR)
    hFigRGB.StackR(i) = rectangle('Position',[0,-i,1,1]);
end
axis([0 1 -5 0])

end

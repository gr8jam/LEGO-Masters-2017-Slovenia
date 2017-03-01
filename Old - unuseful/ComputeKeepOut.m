KeepOut = InitKeepOut(Walls, Obstacles);

fig = figure;
set(fig, 'Position', [0 170 25*35 18*35]); %% matej
hold on;
DrawKeepOut(fig, KeepOut);

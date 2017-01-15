close all;
clear all;
load('StartPose');

fig = figure;
set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on;

for i = 1:length(StartPose)
    x = StartPose(i).x;
    y = StartPose(i).y;
    fi = StartPose(i).fi;
    
    r = 100;
    quiver(x,y,r*cos(fi),r*sin(fi),'m','LineWidth',2)
end

Point  = struct('x',0,...
                'y',0,...
                'fi',0,...
                'theta',0);
           
Points = [];

for i = 1:length(StartPose)
    x = double(StartPose(i).x);
    y = double(StartPose(i).y);
    fi = StartPose(i).fi;
    
    Point.x = double(x);
    Point.y = double(y);
    Point.fi = fi;
    Point.theta = atan2(y-900,x-1250);
    
    Points = [Points Point];
    
    d = sqrt((x-1250)^2 + (y-900)^2);
    plot([1250 1250+d*cos(Point.theta)], [900 900+d*sin(Point.theta)], 'k-')
end

save('PointsWithTheta.mat', 'Points');












    

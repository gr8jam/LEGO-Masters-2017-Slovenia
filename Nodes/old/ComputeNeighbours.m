function ComputeNeighbours

close all;
clear all;

d_max_tr_1 = 290;
d_max_tr_2 = 330;
d_max_tr_3 = 380;

load('PointsWithTheta.mat');

fig = figure;
set(fig, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on;


Nodes = ComputeNodeNeighbours(Points,d_max_tr_1, d_max_tr_2, d_max_tr_3);


for i = 1:length(Nodes)
    x = Nodes(i).x;
    y = Nodes(i).y;
    fi = Nodes(i).fi;
    
    r = 100;
    plot(x,y,'b.','MarkerSize',20)
end


ref = 71;
x = [1250 Nodes(ref).x];
y =  [900 Nodes(ref).y];
theta_ref = Nodes(ref).theta;
plot(x,y, 'k-');
    
draw = [39];

for i = 1:length(draw)
    x = [1250 Nodes(draw(i)).x];
    y =  [900 Nodes(draw(i)).y];
    plot(x,y, 'k-');
    angle = Nodes(draw(i)).theta - theta_ref;
    angle = angle * 180 / pi;
    fprintf('Kot med ref node %i in node %i je: \n %i\n', ref, draw(i), int32(angle));
end

save('Nodes','Nodes','d_max_tr_1','d_max_tr_2','d_max_tr_3');
end

function Nodes = ComputeNodeNeighbours(Points,d_max_tr_1, d_max_tr_2, d_max_tr_3)

fig1 = figure;
set(fig1, 'Position', [1600 -150 25*60 18*60]); %% matej
hold on;
for i = 1:length(Points)
    plot(Points(i).x,Points(i).y,'b.','MarkerSize',20)
end
hj = plot(1250,900,'r.','MarkerSize',20,'erasemode','xor');
hi = plot(1250,900,'g.','MarkerSize',20,'erasemode','xor');
hd = plot(1250,900,'ro','MarkerSize',1,'erasemode','xor');


Neighbour = struct('idx',0,'weight',0);
% Init Neighbours, it is a static array [10] that contains structs
Neighbours = [];
for i = 1:10
    Neighbours = [Neighbours Neighbour];
end

Node = struct('x',0,...
              'y',0,...
              'fi',0,...
              'theta',0, ...
              'Neighbours', Neighbours);
Nodes = [];
for i = 1:length(Points)
    Nodes = [Nodes Node];
end

NeighboursCount = [];
for i = 1:length(Nodes)
    x = Points(i).x;
    y = Points(i).y;
    fi = Points(i).fi;
    theta = Points(i).theta;

    Nodes(i).x = x;
    Nodes(i).y = y;
    Nodes(i).fi = fi;
    Nodes(i).theta = theta;

    switch floor((i-1)/32) + 1 
        case 1
            d_max = d_max_tr_1;
        case 2
            d_max = d_max_tr_2;
        case 3
            d_max = d_max_tr_3;
        otherwise
            d_max = 10;
    end
    
    set(hi,'XData',x,'YData',y);
    set(hd,'XData',x,'YData',y, 'MarkerSize', d_max * 2/3);
    drawnow;
    
    if i == 8
        a = 48;
    end
    
    
    count = 0;
    for j = 1:length(Nodes)
        switch floor((i-1)/32) + 1 
            case 1
                d_max = d_max_tr_1;
                if (65 <= j) && (j <=96)
                    continue;
                end
            case 2
                d_max = d_max_tr_2;
            case 3
                d_max = d_max_tr_3;
                if (1 <= j) && (j <=32)
                    continue;
                end
            otherwise
                d_max = 10;
        end
        
        
        
        if (i ~= j)
            set(hj,'XData',Points(j).x,'YData',Points(j).y);
            alfa = atan2(Points(j).y - Points(i).y, Points(j).x - Points(i).x);
            beta = Points(i).fi - alfa;
            beta = wrapToPi(beta);
            ang_limit = pi/2+pi/36;
            gama = beta * 180 / pi;
            if (-ang_limit <= beta && beta <= ang_limit)
                d = sqrt((Points(i).x-Points(j).x)^2 + ...
                         (Points(i).y-Points(j).y)^2 );
                
                if (d < d_max)
                    count = count + 1;
                    Nodes(i).Neighbours(count).idx = j;
                    Nodes(i).Neighbours(count).weight = d;
                end
            end
        end
            
    end
    NeighboursCount = [NeighboursCount count];
end

end








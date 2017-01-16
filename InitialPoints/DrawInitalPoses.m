function DrawInitalPoses(fig,delay)
global Nodes
if isempty(Nodes)
    error('variable Nodes is empty! \n ');
end
figure(fig)
hold on;

for i = 1:length(Nodes)
    xs = Nodes(i).x;
    ys = Nodes(i).y;
    fi = Nodes(i).fi;
    
    d  = 120;
    xe = d*cos(fi) + xs;
    ye = d*sin(fi) + ys;
    
    [x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,pi/8,25);
    
%     fi_arrow = pi/8;
%     d_arrow = 25;
%     x_arrow = xe + [d_arrow * cos(fi-pi-fi_arrow);
%                     0;
%                     d_arrow * cos(fi-pi+fi_arrow);
%                     0]';
%     y_arrow = ye + [d_arrow * sin(fi-pi-fi_arrow);
%                     0;
%                     d_arrow * sin(fi-pi+fi_arrow);
%                     0]';
%     
    x = [xs xe x_arrow];
    y = [ys ye y_arrow];
    
    plot(x,y,'k-','LineWidth',2);
%     quiver(xs,ys,xe,ye,'k-');
    pause(delay);
end

end


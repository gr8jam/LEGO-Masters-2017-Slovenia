function [x_arrow, y_arrow] =  ComputeArrowHead(xs,ys,xe,ye,fi,d)

fi_arrow = atan2(ys-ye,xs-xe);
d_arrow = d;
x_arrow = xe + [d_arrow*cos(fi_arrow-fi);
                0;
                d_arrow*cos(fi_arrow+fi);
                0]';
y_arrow = ye + [d_arrow*sin(fi_arrow-fi);
                0;
                d_arrow*sin(fi_arrow+fi);
                0]'; 
end

clear all;
close all


x = [1 2];
y = [1 1];
u = [1 1];
v = [1 1];


fig = figure();
h = quiver(x,y,u,v);
axis equal;

pause(1);

x = [1 1.5];
y = [1 1];
u = [-1 -1];
v = [-1 -1];

set(h, 'XData',x ,'YData',y, 'UData',u,'VData',v);

a = get(h, 'XData');
b = get(h, 'UData')



clear all;
close all;

er = -pi:0.001:pi;

f = 1 - abs(er)/pi;
g = cos(er);
h = exp(-5*abs(er/pi));

er = er *180/pi;
figure
hold on
plot(er,f,'r', 'LineWidth', 3)
plot(er,g,'g', 'LineWidth', 3)
plot(er,h,'b', 'LineWidth', 3)
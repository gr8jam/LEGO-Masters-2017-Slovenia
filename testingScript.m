clear all;
close all

figure(1); clf; 
FigureSettings(1,'matej');

L_half = 90;
W_half = 60;

L_iner = 30;
W_iner = 30;

P=[L_iner L_half L_half -L_half -L_half -L_iner -L_iner -L_half -L_half  L_half  L_half  L_iner L_iner;...  % oblika robota
   W_iner W_iner W_half  W_half  W_iner  W_iner -W_iner -W_iner -W_half -W_half -W_iner -W_iner W_iner];


plot(P(1,:),P(2,:)) 

axis([-100 100 -100 100]);

% 
% x = [1 2];
% y = [1 1];
% u = [1 1];
% v = [1 1];
% 
% 
% fig = figure();
% h = quiver(x,y,u,v);
% axis equal;
% 
% pause(1);
% 
% x = [1 1.5];
% y = [1 1];
% u = [-1 -1];
% v = [-1 -1];
% 
% set(h, 'XData',x ,'YData',y, 'UData',u,'VData',v);
% 
% a = get(h, 'XData');
% b = get(h, 'UData')




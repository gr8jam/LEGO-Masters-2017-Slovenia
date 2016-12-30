function [v,w] = Motion(q);
global Robot
DriverRGB();

v = 50;
w = -0.07;

L = Robot.idxL;
D = Robot.idxR;
k = 0.7;
kk = 1.5;

ww = 0;
vv = 0;


if L ~= 17 && D ~= 17
    ww = 0; 
    vv = 100;
    stanje = 1;
elseif L == 17 && D ~= 17
    ww = k;
    vv = 80;
    stanje = 2;
elseif L ~= 17 && D == 17 
    ww = -k;
    vv = 80;
    stanje = 3;
else 
    vv = 40;
    ww = 0;
    stanje = 4;
end

v = vv;
w = ww;
    








u = [v;w];


end
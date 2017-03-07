function [v,w] = ContolerPosition(w_sen)

global PP PF

% x = PP.xRef;
% y = PP.yRef;
% 
% x = Nodes(PP.Goal).x;
% y = Nodes(PP.Goal).y;
% fi = Nodes(PP.Goal).fi;


eX = PP.xRef - PF.x;
eY = PP.yRef - PF.y;

fiRef = atan2(eY,eX);

eFi = wrapToPi(fiRef - PF.fi);
eD = sqrt(eX^2 + eY^2);

K1 = 3;
K2 = 0.3;
w = K1*eFi - K2*w_sen; % PD controler
w = ramp_omega(w);

G = exp(-15*abs(eFi));

K3 = 10;
v = G * K3 * eD;
v = ramp_velocity(v);

end




function v = ramp_velocity(v_ref)
% global Ts
persistent v_old
if isempty(v_old)
    v_old = 0;
end

dv = (v_ref - v_old);
dv_max = 10;
dv_min = -10;
if dv > dv_max
    dv = dv_max;
elseif dv < dv_min
    dv = dv_min;
end

v = v_old + dv;

v_max = 150;
v_min = -150;
if v > v_max
    v = v_max;
elseif v < v_min
    v = v_min;
end

v_old = v;

end

function w = ramp_omega(w_ref)
% global Ts
persistent w_old
if isempty(w_old)
    w_old = 0;
end

dw = (w_ref - w_old);
dw_max = 5 * pi/180;
dw_min = -5 * pi/180;
if dw > dw_max
    dw = dw_max;
elseif dw < dw_min
    dw = dw_min;
end

w = w_old + dw;

w_max = 45 * pi/180;
w_min = -45 * pi/180;
if w > w_max
    w = w_max;
elseif w < w_min
    w = w_min;
end

w_old = w;

end


function a = CorrectAngle(a)
    a=atan2(sin(a),cos(a));   % put in range [-pi,pi]
end

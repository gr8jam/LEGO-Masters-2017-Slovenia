function [v,w] = ContolerPosition(q_ref, q_sen, w_sen)


e(1:2) = q_ref(1:2) - q_sen(1:2);
q_ref(3) = atan2((q_ref(2) - q_sen(2)), (q_ref(1) - q_sen(1)));
e(3) = CorrectAngle(q_ref(3) - q_sen(3));



K1 = 3;
K2 = 0.3;
w = K1*e(3) - K2*w_sen; % PD controler
w = ramp_omega(w);


e_d = sqrt(e(1)^2 + e(2)^2);

G = exp(-15*abs(e(3)));

K3 = 10;
v = G * K3 * e_d;
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

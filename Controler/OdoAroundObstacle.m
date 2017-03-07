function [ v, w ] = OdoAroundObstacle(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global OdoRobot Robot
%     -45*pi/180
    q1 = [150 -85 0];
    q2 = [350 -160 0];
    q3 = [550 -85 0];
    q4 = [700 0 0];
    
    q_points = [q1; q2; q3; q4];
    
    if OdoRobot.F1 == 0
        OdoRobot.q_ref = q1;
        OdoRobot.F1 = 1;
    end
    OdoRobot.q_ref
    OdoRobot.q;
    %%%%%% determine robot inputs
    % error calculation
    e(1:2) = OdoRobot.q_ref(1:2) - OdoRobot.q(1:2);
    OdoRobot.q_ref(3) = atan2((OdoRobot.q_ref(2) - OdoRobot.q(2)), (OdoRobot.q_ref(1) - OdoRobot.q(1)));
    e(3) = wrapToPi(OdoRobot.q_ref(3) - OdoRobot.q(3));
    
    
    % orientation controler
%     K = 3;
%     w = K*e(3);             % P controler
    K1 = 3;
    K2 = 0.3;
    w = K1*e(3) - K2*OdoRobot.w; % PD controler
%     v = 0;
    % position controler
    e_d = sqrt(e(1)^2 + e(2)^2);
    % G = 1 - abs(e(3))/pi;
    G = abs(cos(e(3)));
   if (e_d < 1) 
        OdoRobot.idx = OdoRobot.idx + 1;
        if OdoRobot.idx > 4
            OdoRobot.idx = 4;
            Robot.Motrion.Odo = 0;
            v = 0;
            w = 0;
            2020
        end
        OdoRobot.q_ref = q_points(OdoRobot.idx,:);
        v = 0;
        w = 0;
        10
   else
        K3 = 1;
        v = G * K3 * e_d;
    end

    OdometryRobot(v,w);
    

end


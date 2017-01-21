function testingTransRot
q = [1 3 pi/4]';

x = q(1);
y = q(2);
fi = q(3);

R_L2G = getRotMat(fi);   % Rotational matrix from LOCAL to GLOBAL
T_L2G = getTrasMat(x,y); % Trasnlation matrix from LOCAL to GLOBAL

qC_local = [0 0 1]';     % Center of robot in LOCAL coordinates     
qC_global = T_L2G * R_L2G * qC_local;

qR_local = [5 -3 1]';    % Position of RIGHT rgb sensor in LOCAL coordinates
qR_global = T_L2G * R_L2G * qR_local;

qL_local = [5 3 1]';     % Position of LEFT rgb sensor in LOCAL coordinates
qL_global = T_L2G * R_L2G * qL_local;

close all
figure
hold on
axis equal

qC = qC_global;
plot(qC(1),qC(2), 'ro', 'LineWidth', 2)
plot([qC(1) qC(1)+3*cos(fi)],[qC(2) qC(2)+3*sin(fi)],'r-', 'LineWidth', 2)

qR = qR_global;
plot(qR(1),qR(2), 'b*', 'LineWidth', 2)

qL = qL_global;
plot(qL(1),qL(2), 'b*', 'LineWidth', 2)


% q = qC_local;
% q(3) = 0;
% plot(q(1),q(2), 'ro', 'LineWidth', 2)
% plot([q(1) q(1)+3*cos(q(3))],[q(2) q(2)+3*sin(q(3))],'r-', 'LineWidth', 2)
% 
% qR = qR_local;
% plot(qR(1),qR(2), 'b*', 'LineWidth', 2)
% 
% qL = qL_local;
% plot(qL(1),qL(2), 'b*', 'LineWidth', 2)
end



function R = getRotMat(theta)
    R = [cos(theta) -sin(theta) 0;
         sin(theta)  cos(theta) 0;
             0           0      1];       
end

function T = getTrasMat(tx,ty)
    T = [1 0 tx;
         0 1 ty;
         0 0  1];
end
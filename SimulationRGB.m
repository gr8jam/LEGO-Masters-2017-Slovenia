function [idxLeft, idxRight] = SimulationRGB(q)

global Robot

x = q(1);
y = q(2);
fi = q(3);

% Lokalni koordinatni sistem je izbran tako, da je x os vzporedna
% smeri gibanja robota, ko se ta pelje naravnost. Središèe lokalnega
% koordinatnega sistema se nahaja na središè osi med pogonskima kolesoma
% robota.

R_L2G = getRotMat(fi);   % Rotational matrix from LOCAL to GLOBAL
T_L2G = getTrasMat(x,y); % Trasnlation matrix from LOCAL to GLOBAL

% qC_local = [0 0 1]';     % Center of robot in LOCAL coordinates     
% qC_global = T_L2G * R_L2G * qC_local;

qR_local = [50 -30 1]';    % Position of RIGHT rgb sensor in LOCAL coordinates
qR_global = T_L2G * R_L2G * qR_local;

qL_local = [50 30 1]';     % Position of LEFT rgb sensor in LOCAL coordinates
qL_global = T_L2G * R_L2G * qL_local;

idxRight = getIdxFromPolygonMap(qR_global);
idxLeft = getIdxFromPolygonMap(qL_global);

Robot.posL = qL_global(1:2);
Robot.posR = qR_global(1:2);

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
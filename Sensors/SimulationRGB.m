function [idxLeft, idxRight, posLeft, posRight] = SimulationRGB(x, y, fi)

% Lokalni koordinatni sistem je izbran tako, da je x os vzporedna
% smeri gibanja robota, ko se ta pelje naravnost. Središèe lokalnega
% koordinatnega sistema se nahaja na središè osi med pogonskima kolesoma
% robota.

% R_L2G = getRotMat(fi);   % Rotational matrix from LOCAL to GLOBAL
% T_L2G = getTrasMat(x,y); % Trasnlation matrix from LOCAL to GLOBAL

% qC_local = [0 0 1]';     % Center of robot in LOCAL coordinates     
% qC_global = T_L2G * R_L2G * qC_local;

% qR_local = [50 -30 1]';    % Position of RIGHT rgb sensor in LOCAL coordinates
% qR_global = T_L2G * R_L2G * qR_local;

% qL_local = [50 30 1]';     % Position of LEFT rgb sensor in LOCAL coordinates
% qL_global = T_L2G * R_L2G * qL_local;

d = 58.3095;
theta = 0.5404;

qR_global(1) = x + d * cos(fi-theta);
qR_global(2) = y + d * sin(fi-theta);
qL_global(1) = x + d * cos(fi+theta);
qL_global(2) = y + d * sin(fi+theta);



idxRight = getIdxFromPolygonMap(qR_global);
idxLeft  = getIdxFromPolygonMap(qL_global);

posLeft =  qL_global(1:2);
posRight = qR_global(1:2);

end




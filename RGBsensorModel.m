function color = RGBsensorModel(x,y)

% white = [1 1 1];
% black = [0 0 0];
% red   = [1 0 0];
% green = [0 1 0];
% blue  = [0 0 1];
% yellow= [1 1 0];
% brown = [139 69 19]./255;

global white; global black;
global red;   global green;
global blue;  global yellow;
global brown;  global cayan;

white = 119;
black = 107;
red   = 114;
green = 103;
blue  = 98;
yellow= 121;
brown = 109; % magneta
cayan = 99;

A = [ 625 ;  275];
B = [ 625 ; -275];
C = [-625 ; -275];
D = [-625 ;  275];
E = [ 1250;  900];
F = [ 1250; -900];
G = [-1250; -900];
H = [-1250;  900];
I = [   99; -640];
J = [  -99;  640];
K = [  165;    0];
L = [ -165;    0];

xA = A(1);
xB = B(1);
xC = C(1);
xD = D(1);
xE = E(1);
xF = F(1);
xG = G(1);
xH = H(1);
xI = I(1);
xJ = J(1);
xK = K(1);
xL = L(1);


yA = A(2);
yB = B(2);
yC = C(2);
yD = D(2);
yE = E(2);
yF = F(2);
yG = G(2);
yH = H(2);
yI = I(2);
yJ = J(2);
yK = K(2);
yL = L(2);

kDJ = (D(2)-J(2))/(D(1)-J(1));
kJK = (J(2)-K(2))/(J(1)-K(1));

% r1 = 15;
% r2 = 97.5;
% r3 = 157.5;
% r4 = 177.5;
% r5 = 250;

Area1_tr1Colors = [yellow red brown blue];
Area1_tr1Limits = [-147 0 147];
Area1_tr2Colors = [blue yellow red blue];
Area1_tr2Limits = [-177 0 177];
Area1_tr3Colors = [blue red yellow green];
Area1_tr3Limits = [-207 0 207];
    
Area2_tr1Colors = [brown red green yellow];
Area2_tr1Limits = [225 280 330];
Area2_tr2Colors = [red brown green yellow blue];
Area2_tr2Limits = [240 270 315 340];
Area2_tr3Colors = [green blue brown red brown blue];
Area2_tr3Limits = [235 260 280 310 340];

Area3_tr1Colors = [brown yellow blue red blue];
Area3_tr1Limits = ([55 70 83 100]);
Area3_tr2Colors = [red yellow green brown];
Area3_tr2Limits = [48 75 105];
Area3_tr3Colors = [green brown blue];
Area3_tr3Limits = [55 115];

Area4_tr1Colors = [green brown blue green];
Area4_tr1Limits = [48 195 342];
Area4_tr2Colors = [green yellow red brown];
Area4_tr2Limits = [40 217 394];
Area4_tr3Colors = [blue brown blue];
Area4_tr3Limits = [90 297];

Area5_tr1Colors = [brown red green yellow];
Area5_tr1Limits = flip((180 - Area2_tr1Limits) + 360);
Area5_tr2Colors = [yellow blue brown green];
Area5_tr2Limits = flip((180 - Area2_tr2Limits) + 360);
Area5_tr3Colors = [blue red yellow red blue];
Area5_tr3Limits = flip((180 - Area2_tr3Limits) + 360);

Area6_tr1Colors = [brown green red brown];
Area6_tr1Limits = Area1_tr1Limits;
Area6_tr2Colors = [brown yellow green yellow];
Area6_tr2Limits = Area1_tr2Limits;
Area6_tr3Colors = [red brown green blue];
Area6_tr3Limits = Area1_tr3Limits;

Area7_tr1Colors = [green brown yellow brown];
Area7_tr1Limits = (Area2_tr1Limits - 180);
Area7_tr2Colors = [brown green brown red brown];
Area7_tr2Limits = (Area2_tr2Limits - 180);
Area7_tr3Colors = [brown green yellow blue brown red];
Area7_tr3Limits = (Area2_tr3Limits - 180);

Area8_tr1Colors = [green brown yellow blue green];
Area8_tr1Limits = (Area3_tr1Limits + 180);
Area8_tr2Colors = [brown red brown red];
Area8_tr2Limits = (Area3_tr2Limits + 180);
Area8_tr3Colors = [brown red blue];
Area8_tr3Limits = (Area3_tr3Limits + 180);

Area9_tr1Colors = [brown green blue red green];
Area9_tr1Limits = [48 195 342 489];
Area9_tr2Colors = [blue yellow blue red];
Area9_tr2Limits = [40 217 394];
Area9_tr3Colors = [yellow green blue red];
Area9_tr3Limits = [90 297 497];

Area10_tr1Colors = [blue yellow brown];
Area10_tr1Limits = flip((360 - Area2_tr1Limits));
Area10_tr2Colors = [blue green brown blue];
Area10_tr2Limits = flip((360 - Area2_tr2Limits));
Area10_tr3Colors = [green brown blue green yellow];
Area10_tr3Limits = flip((360 - Area2_tr3Limits));

%% Area I
if ((xA <= x) && (x <= xE) && (yB <= y) && (y <= yA))
    T = translate(-xA, 0);
    R = rotate(0);
    transformMat = R*T;
    
    linear = true;
    color = devideArea(x,y,transformMat,linear, ...
                       Area1_tr1Limits, Area1_tr1Colors,...
                       Area1_tr2Limits, Area1_tr2Colors,...
                       Area1_tr3Limits, Area1_tr3Colors);
    
%% Area II
elseif ((xI <= x) && (x <= xF) && (yF <= y) && (y <= yB) && (y-yB < kDJ*(x-xB)))
    T = translate(-xB, -yB);
    R = rotate(0);
    transformMat = R*T;
    
    linear = false;
    color = devideArea(x,y,transformMat,linear, ...
                       Area2_tr1Limits, Area2_tr1Colors,...
                       Area2_tr2Limits, Area2_tr2Colors,...
                       Area2_tr3Limits, Area2_tr3Colors);

%% Area III
elseif ((x < xA) && (y < 0) && (y-yB > kDJ*(x-xB)) && (y-yI > kJK*(x-xI)))    
    T = translate(-I(1), -I(2));
    transformMat = T;
    color = devideArea3and8(x,y,transformMat,...
                            Area3_tr1Limits, Area3_tr1Colors,...
                            Area3_tr2Limits, Area3_tr2Colors,...
                            Area3_tr3Limits, Area3_tr3Colors);
    
%% Area IV
elseif ((xC < x) && (x < xI) && (yF <= y) && (y < 0) && (y-yI < kJK*(x-xI)) && (y-yC > kJK*(x-xC)))
    P = C;
    theta1 = atan(kJK);
    P_ = P + 15 .* [cos(theta1); sin(theta1)]; 
    theta2 = atan2(P_(2),P_(1)) + pi/2;
    
    R = rotate(-theta2);
    T = translate(+16, norm(P,2));
    transformMat = T*R;
    
    linear = true;
    color = devideArea(x,y,transformMat,linear, ...
                       Area4_tr1Limits, Area4_tr1Colors,...
                       Area4_tr2Limits, Area4_tr2Colors,...
                       Area4_tr3Limits, Area4_tr3Colors);
    
%% Area V
elseif ((xG <= x) && (yG <= y) && (y <= yC) && (y-yC < kJK*(x-xC)))
    T = translate(-xC, -yC);
    R = rotate(0);
    transformMat = R*T;
    
    linear = false;
    color = devideArea(x,y,transformMat,linear, ...
                       Area5_tr1Limits, Area5_tr1Colors,...
                       Area5_tr2Limits, Area5_tr2Colors,...
                       Area5_tr3Limits, Area5_tr3Colors);
    
%% Area VI    
elseif ((xG <= x) && (x <= xC) && (yC <= y) && (y <= yD))
    T = translate(-xC, 0);
    R = rotate(pi);
    transformMat = R*T;
    
    linear = true;
    color = devideArea(x,y,transformMat,linear, ...
                       Area6_tr1Limits, Area6_tr1Colors,...
                       Area6_tr2Limits, Area6_tr2Colors,...
                       Area6_tr3Limits, Area6_tr3Colors);

%% Area VII
elseif ((xH <= x) && (x <= xJ) && (yD <= y) && (y <= yH) && (y-yD > kDJ*(x-xD)))
    T = translate(-xD, -yD);
    R = rotate(0);
    transformMat = R*T;
    
    linear = false;
    color = devideArea(x,y,transformMat,linear, ...
                       Area7_tr1Limits, Area7_tr1Colors,...
                       Area7_tr2Limits, Area7_tr2Colors,...
                       Area7_tr3Limits, Area7_tr3Colors);
                   
%% Area VIII
elseif ((xD <= x) && (0 < y) && (y-yD < kDJ*(x-xD)) && (y-yJ < kJK*(x-xJ)))
    T = translate(-J(1), -J(2));
    transformMat = T;
    color = devideArea3and8(x,y,transformMat,...
                            Area8_tr1Limits, Area8_tr1Colors,...
                            Area8_tr2Limits, Area8_tr2Colors,...
                            Area8_tr3Limits, Area8_tr3Colors);
    
    
%% Area IX   
elseif ((xJ < x) && (x < xA) && (0 <= y) && (y <= xE) && (y-yJ > kJK*(x-xJ)) && (y-yA < kJK*(x-xA)))
    P = A;
    theta1 = atan(kJK) + pi;
    P_ = P + 15 .* [cos(theta1); sin(theta1)]; 
    theta2 = atan2(P_(2),P_(1)) + pi/2;
    
    R = rotate(-theta2);
    T = translate(+16, norm(P,2));
    transformMat = T*R;
    
    linear = true;
    color = devideArea(x,y,transformMat,linear, ...
                       Area9_tr1Limits, Area9_tr1Colors,...
                       Area9_tr2Limits, Area9_tr2Colors,...
                       Area9_tr3Limits, Area9_tr3Colors);
                   
%% Area X
elseif ((x <= xE) && (yA <= y) && (y <= yE) && (y-yA > kJK*(x-xA)))
    T = translate(-xA, -yA);
    R = rotate(0);
    transformMat = R*T;
    
    linear = false;
    color = devideArea(x,y,transformMat,linear, ...
                       Area10_tr1Limits, Area10_tr1Colors,...
                       Area10_tr2Limits, Area10_tr2Colors,...
                       Area10_tr3Limits, Area10_tr3Colors);
else
    color = black;
end
end



function color = devideArea(x,y,transformMat,linear, ...
                            tr1Limits, tr1Colors,...
                            tr2Limits, tr2Colors,...
                            tr3Limits, tr3Colors)
global white; global black;
global red;   global green;
global blue;  global yellow;
global brown;  global cayan;

q = [x ; y; 1];
qT = transformMat * q;

if linear
    r = qT(1);
    fi = qT(2);
else
    r = sqrt(qT(1)^2 + qT(2)^2);
    fi = atan2(qT(2),qT(1)) * (180/pi);
    if (fi < 0)
        fi = fi + 360;
    end
end

if (r < 15)
    %% Wall
    color = black;
elseif ((97.5 <= r) && (r < 157.5))
    %% Track 1
    color = devideTrack(fi,tr1Limits,tr1Colors);
elseif ((157.5 <= r) && (r < 177.5))
    color = black;
elseif ((250 <= r) && (r < 310))
    %% Track 2
    color = devideTrack(fi,tr2Limits,tr2Colors);
elseif ((310 <= r) && (r < 330))
    color = black;
elseif ((402.5 <= r) && (r < 462.5))
    %% Track 3
    color = devideTrack(fi,tr3Limits,tr3Colors);
elseif ((462.5 <= r) && (r < 482.5))
    color = black;
elseif ((565 <= r) && (r < 625))
    %% Outbound
    color = red;
elseif ((625 <= r))
    color = black;
else
    color = white;
end

end

function color = devideArea3and8(x,y,transformMat,...
                                 tr1Limits, tr1Colors,...
                                 tr2Limits, tr2Colors,...
                                 tr3Limits, tr3Colors)
global white; global black;
global red;   global green;
global blue;  global yellow;
global brown;  global cayan;

q = [x ; y; 1];
qT = transformMat * q;

r = sqrt(qT(1)^2 + qT(2)^2);
fi = atan2(qT(2),qT(1)) *(180/pi);
if (fi < 0)
    fi = fi + 360;
end
    
if (r < 15)
    %% Wall
    color = black;
elseif ((482.5 <= r) && (r < 542.5))
    %% Track 1
    color = devideTrack(fi,tr1Limits,tr1Colors);
elseif ((462.5 <= r) && (r < 482.5))
    color = black;
elseif ((330 <= r) && (r < 390))
    %% Track 2
    color = devideTrack(fi,tr2Limits,tr2Colors);
elseif ((310 <= r) && (r < 330))
    color = black;
elseif ((177.5 <= r) && (r < 237.5))
    %% Track 3
    color = devideTrack(fi,tr3Limits,tr3Colors);
elseif ((157.5 <= r) && (r < 177.5))
    color = black;
elseif ((15 <= r) && (r < 75))
    %% Outbound
    color = red;
elseif ((625 <= r))
    color = black;
else
    color = white;
end

end
    
function color = devideTrack(fi,trLimits,trColors)
global white; global black;
global red;   global green;
global blue;  global yellow;
global brown;  global cayan;


if isempty(trLimits)
    color = cayan;
    return
end

if (fi < trLimits(1))
    color = trColors(1);

elseif (trLimits(end) <= fi)
    color = trColors(end);
    
else
    for i = 2:length(trLimits)   
        if ((trLimits(i-1) <= fi) && (fi < trLimits(i)))
            color = trColors(i);
        end
    end
end
        
end


function R = rotate(theta)
    R = [cos(theta) -sin(theta) 0;
         sin(theta)  cos(theta) 0;
             0           0      1];       
end

function T = translate(tx,ty)
    T = [1 0 tx;
         0 1 ty;
         0 0  1];
end



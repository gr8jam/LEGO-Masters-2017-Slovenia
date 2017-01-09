function [fi] = getInitialPointsAngle(xx,yy)

x = double(xx - 1250);
y = double(yy - 900);

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


kDJ = 34.8 * pi / 180;
kJK = -114 * pi / 180;

%% Area I
if ((xA <= x) && (x <= xE) && (yB <= y) && (y <= yA))
    fi = -pi/2;
    
%% Area II
elseif ((xI <= x) && (x <= xF) && (yF <= y) && (y <= yB) && (y-yB < kDJ*(x-xB)))
    x2 = x - xB;
    y2 = y - yB;
    fi = atan2(y2,x2) - pi/2;
    
%% Area III
elseif ((x < xA) && (y < 0) && (y-yB > kDJ*(x-xB)) && (y-yI > kJK*(x-xI)))    
    x3 = x - xI;
    y3 = y - yI;
    fi = atan2(y3,x3) + pi/2;

%% Area IV
elseif ((xC < x) && (x < xI) && (yF <= y) && (y < 0) && (y-yI < kJK*(x-xI)) && (y-yC > kJK*(x-xC)))
    fi = atan(kJK) - pi/2;
        
%% Area V
elseif ((xG <= x) && (yG <= y) && (y <= yC) && (y-yC < kJK*(x-xC)))
    x5 = x - xC;
    y5 = y - yC;
    fi = atan2(y5,x5) - pi/2;

%% Area VI    
elseif ((xG <= x) && (x <= xC) && (yC <= y) && (y <= yD))
    fi = pi/2;

%% Area VII
elseif ((xH <= x) && (x <= xJ) && (yD <= y) && (y <= yH) && (y-yD > kDJ*(x-xD)))
    x7 = x - xD;
    y7 = y - yD;
    fi = atan2(y7,x7) - pi/2;
                  
%% Area VIII
elseif ((xD <= x) && (0 < y) && (y-yD < kDJ*(x-xD)) && (y-yJ < kJK*(x-xJ)))
    x8 = x - xJ;
    y8 = y - yJ;
    fi = atan2(y8,x8) + pi/2;
  
%% Area IX   
elseif ((xJ < x) && (x < xA) && (0 <= y) && (y <= xE) && (y-yJ > kJK*(x-xJ)) && (y-yA < kJK*(x-xA)))
    fi = atan(kJK) + pi/2;
                   
%% Area X
elseif ((x <= xE) && (yA <= y) && (y <= yE) && (y-yA > kJK*(x-xA)))
    x10 = x - xA;
    y10 = y - yA;
    fi = atan2(y10,x10) - pi/2;
%% The Rest   
else
    color = 1;
end
end





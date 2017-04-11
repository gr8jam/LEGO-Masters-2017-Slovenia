function DrawRobot(q,tip)
global hFigMap

L_half = 90;
W_half = 60;
L_iner = 30;
W_iner = 30;
P=[L_iner L_half L_half -L_half -L_half -L_iner -L_iner -L_half -L_half  L_half  L_half  L_iner L_iner;...  % oblika robota
   W_iner W_iner W_half  W_half  W_iner  W_iner -W_iner -W_iner -W_half -W_half -W_iner -W_iner W_iner];

theta = q(3); 
Rkolo=[cos(theta) -sin(theta); sin(theta) cos(theta)];
T=repmat([q(1);q(2)],1,size(P,2)) ;

% toèke obrisa robota transliramo in rotiramo
P=Rkolo*P+T; 
set(hFigMap(tip),'XData',P(1,:),'YData',P(2,:))   % izris dejanskega robota
end


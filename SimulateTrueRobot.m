function SimulateTrueRobot(v,w)
  global Ts TrueRobot
  flag_sum = 0; % stikalo za vkolop ali izkolp šuma
  
  %nimamo toènega podatka o dimenzijah robota Rkolo in Lrob, ki so v resnici
  Rt=TrueRobot.R+0.0005 * 1;
  Lt=TrueRobot.L+0.001 * 1;
  % dodatno se dejansko kolo zaradi majnih zdrsov, neravnin, itd... vrti z
  % nekim dodanim šumom
  SIGMA_W=0.3;
  % kotne hitrosti koles glede na vhode z dodanim šumom
  wR=1/(TrueRobot.R)*(v+w*(TrueRobot.L)/2)+SIGMA_W*randn(1,1)*flag_sum;
  wL=1/(TrueRobot.R)*(v-w*(TrueRobot.L)/2)+SIGMA_W*randn(1,1)*flag_sum;
  
  % dejanska hitrost robota je torej
    vt=Rt/2*(wR+wL);
    wt=Rt/Lt*(wR-wL);
   
 	TrueRobot.q(1)= TrueRobot.q(1) + Ts*vt*cos( TrueRobot.q(3) + Ts*wt/2 );
	TrueRobot.q(2)= TrueRobot.q(2) + Ts*vt*sin( TrueRobot.q(3) + Ts*wt/2 );
    TrueRobot.q(3)= TrueRobot.q(3) + Ts*wt;
    
    TrueRobot.q(3)=wrapToPi(TrueRobot.q(3));    % popravi kot q(3)  
    
end


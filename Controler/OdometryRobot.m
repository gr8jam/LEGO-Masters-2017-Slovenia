function OdometryRobot(v,w)
  global Ts OdoRobot
  flag_sum = 0; % stikalo za vkolop ali izkolp šuma
  
  %nimamo toènega podatka o dimenzijah robota Rkolo in Lrob, ki so v resnici
  Rt=OdoRobot.R+0.0005 * 0;
  Lt=OdoRobot.L+0.001 * 0;
  % dodatno se dejansko kolo zaradi majnih zdrsov, neravnin, itd... vrti z
  % nekim dodanim šumom
  SIGMA_W=0.3;
  % kotne hitrosti koles glede na vhode z dodanim šumom
  wR=1/(OdoRobot.R)*(v+w*(OdoRobot.L)/2)+SIGMA_W*randn(1,1)*flag_sum;
  wL=1/(OdoRobot.R)*(v-w*(OdoRobot.L)/2)+SIGMA_W*randn(1,1)*flag_sum;
  
  % dejanska hitrost robota je torej
    vt=Rt/2*(wR+wL);
    wt=Rt/Lt*(wR-wL);
    OdoRobot.v = vt;
    OdoRobot.w = wt;
   
 	OdoRobot.q(1)= OdoRobot.q(1) + Ts*vt*cos( OdoRobot.q(3) + Ts*wt/2 );
	OdoRobot.q(2)= OdoRobot.q(2) + Ts*vt*sin( OdoRobot.q(3) + Ts*wt/2 );
    OdoRobot.q(3)= OdoRobot.q(3) + Ts*wt;
    
    OdoRobot.q(3)=wrapToPi(OdoRobot.q(3));    % popravi kot q(3)  
    q = OdoRobot.q(3)
end

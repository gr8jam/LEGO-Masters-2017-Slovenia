function diffDrive_ParticleFilter
close all, clear all 
global Rkolo Lrob Ts Okolje


DRAW=1;      % enable animation
DRAW_MORE=0; % enable more animation
LeOdometrija=0;


Ts=0.033; % sample time
t=0:Ts:10; % time vector
Rkolo=0.04; % wheel radious
Lrob=0.08; % distance between the wheels

q=[1 0.5 0];	% initial pose 


q_est=q'+[1 .9 pi/8]'*.5*1;  % suppose we know robot initial pose or add some error to it
%q_est = q';
Qt=[];Qo=[];E=[];Etrans=[];U=[];Tvzorcenja=[]; EE=[];Z=[];
tt=0;



% noise
Q=diag([0.1^2,0.2^2])*10; % variance of actuator noise (translational velocity, angular velocity)
R=diag([0.1^2])*1;        % variance of distance sensor noise

% initialize particels
nParticles=300;
xP=repmat(q_est,1,nParticles)+diag([1,1,pi/2]*.5)*randn(3,nParticles); % inicicalizacija delcev
% all particles have equal weights
W = ones(nParticles,1)/nParticles;





%graphic initialisation
global hhh  
if (DRAW) InitGrafic(xP); end

% environment definition
Okolje=[];
Okolje=DefinirajOkolje();



    %%%%%%%%%%% store results
    Qt=[Qt;q]; 
    Qo=[Qo;q_est']; 
    U=[U;0 0]; 
    Z=[Z; 0 0 0];
    Tvzorcenja=[Tvzorcenja; tt];
    tt=tt+Ts;




for i=1:length(t)
     
    
    %%%%%%%%%%% control definition of inputs 
    v=.5*1;
    w=.5*1.4;    
    u=[v;w];
    
    
    
    %%%%%%%%%%% true robot motion
    [q]=SimulacijaDejanskegaRobora(q,v,w);
    

    
    %%%%%%%%%%% distance sensor of true robot    
    zTrue= [SensorDistance(-2*pi/3,q,R);  % returns distance to the obstacles in three directions, includes also noise with variance R
           SensorDistance(0,q,R);
           SensorDistance(2*pi/3,q,R)];
 
       
    %%%%%%%%%%%% Particle filter (insert your code here)
    
    % Predikcija delcev
    for(p = 1:nParticles)
        un=u + sqrt(Q)*randn(2,1)*1 ; % delce premaknemo s šumom modela
        xP(:,p) = xP(:,p) + Ts*[ un(1)*cos(xP(3,p)); ...
        un(1)*sin(xP(3,p)); ...
        un(2) ] ;
        xP(3,p) = PopraviCiklicnostKota(xP(3,p));
    end;

    
    % Korekcija delcev
    for(p = 1:nParticles)
    % ocenjena meritev za vsak delec

        z= [SensorDistance(-2*pi/3,xP(:,p),0);  % returns distance to the obstacles in three directions, includes also noise with variance R
            SensorDistance(      0,xP(:,p),0);
            SensorDistance( 2*pi/3,xP(:,p),0)];
        
        Innov = zTrue-z; %doloèimo inovacijo

    % doloèimo uteži delcev (njihovo verjetnost)
        RR=eye(3)*R; % kovarianèna matrika meritve
        W(p) = exp(-0.5*Innov'*inv(RR)*Innov)+0.0001;
    end;

    iNextGeneration=resampleParticles(W,nParticles);
    xP = xP(:,iNextGeneration);
    % ocena stanja je povpreèje delcev
    x = mean(xP,2);
    x(3) = PopraviCiklicnostKota(x(3));
    
    
    % Particle filter (PF) estimate is obtained by the avarage od praticle states 
    q_est = x;     % here write current pose estimate from PF 


     
    
    %%%%%%%%%%% store results
    Qt=[Qt;q]; 
    Qo=[Qo;q_est']; 
    U=[U;u']; 
    Z=[Z; zTrue'];

    Tvzorcenja=[Tvzorcenja; tt];
    tt=tt+Ts;
 
    
    
    
    
    
    
   if (DRAW)
       DrawRobot(q',1);     % drugi parameter: robot=1, odometrija=2
       DrawRobot(q_est',2); % drugi parameter: robot=1, odometrija=2
       set(hhh(3),'XData',Qt(:,1),'YData',Qt(:,2));  % izris prave poti
       set(hhh(4),'XData',Qo(:,1),'YData',Qo(:,2));  % izris ocenjene poti
     if( ~LeOdometrija)
       set(hhh(5),'XData',xP(1,:),'YData',xP(2,:));  % izris delcev
       rr=.15;       
        if(DRAW_MORE)
           set(hhh(6), ...   % particle dir
                'XData', reshape([xP(1,:); xP(1,:)+rr*cos(xP(3,:)); nan(1,nParticles)], 1, []), ...
                'YData', reshape([xP(2,:); xP(2,:)+rr*sin(xP(3,:)); nan(1,nParticles)], 1, []), ...
                'ZData', reshape([10+0.1*ones(1, nParticles); 10+0.1*ones(1, nParticles); 10+0.1*ones(1, nParticles)], 1, []));
         end
     end
     
     if(DRAW_MORE)
      set(hhh(7), ...   % sensor
            'XData', reshape([q(1)*ones(1,3); q(1)*ones(1,3)+zTrue'.*cos(q(3)+[-2*pi/3,0,2*pi/3]); nan(1,3)], 1, []), ...
            'YData', reshape([q(2)*ones(1,3); q(2)*ones(1,3)+zTrue'.*sin(q(3)+[-2*pi/3,0,2*pi/3]); nan(1,3)], 1, []), ...
            'ZData', reshape([10+0.1*ones(1, 3); 10+0.1*ones(1, 3); 10+0.1*ones(1, 3)], 1, []));
     end
     
      drawnow;        
        
      pause(0.03);
      % pause(1);
        
   end
   
end

figure
plot(Qt(:,1),Qt(:,2),Qo(:,1),Qo(:,2),'--')
xlabel('x [m]'),ylabel('y [m]')
figure
plot(Tvzorcenja,U(:,1),Tvzorcenja,U(:,2),'--')
xlabel('t [s]'),ylabel('v [m/s], \omega [rad/s]'),legend('v','\omega'),
figure
plot(Tvzorcenja,Z(:,1),Tvzorcenja,Z(:,2),Tvzorcenja,Z(:,3),'--')
xlabel('t [s]'),ylabel('d [m/s]'),legend('d1','d2','d3'),






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% FUNKCIJE    %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [minRazdalja] = SensorDistance(kot, q, R)
    global Okolje
  % parametri:
  % kot = kot pod katerim merimo razdaljo do ovire
  % q= lega robota
  % R= varianca šuma meritve razdalje
  % minRazdalja = razdalja od robota do ovire v smeri kota
  
  MAX_DOSEG_SENZORJA=20;
  
    % premici
    % A1,B1,C1;           // premica, ki jo doloca robot in smer tipanja robota
    % A2,B2,C2;           // premica, ki jo dolocata tocki daljice okolja
    
    xr=q(1); yr=q(2); fir=q(3);
    KotTipanja=kot+fir;
 
    A1=sin(KotTipanja);  % enaèba premice žarka A1x+B1y+C1=0
    B1=-cos(KotTipanja);
    C1=-xr*A1-yr*B1;
    
    Det=0;
    minRazdalja=100000;
 
     % tu testiraj premice in vrni kot
     for i=1:size(Okolje,1)
        x1=Okolje(i,1); y1=Okolje(i,2); x2=Okolje(i,3);  y2=Okolje(i,4);

        A2=  y2-y1;   % enaèba premice daljice okola A2x+B2y+C2=0  
        B2= -x2+x1;
        C2= -x1*A2 - y1*B2;
      
        Det=A1*B2-A2*B1;

        if(Det ~= 0)           % premice se krizata
            % dolocimo presecisce
            xp=(B1*C2-B2*C1)/Det;
            yp=(C1*A2-C2*A1)/Det;

            razdalja = sqrt((xr-xp)^2+(yr-yp)^2);
            

            % ali je ta razdalja sploh smiselna - objekt je pred senzorjem in ne zadaj
           if( (cos(KotTipanja)*(xp-xr)+sin(KotTipanja)*(yp-yr)) >=0)
                % ali je tocka presicisca znotraj daljice
                pogoj1= (x1<= xp && xp <= x2) || (x2<= xp && xp <= x1) || abs(x1-x2)<3*eps;
                pogoj2= (y1<= yp && yp <= y2) || (y2<= yp && yp <= y1) || abs(y1-y2)<3*eps;

                if(pogoj1&&pogoj2)
                    if(razdalja<minRazdalja)
                        minRazdalja=razdalja;
                    end
                end
           end
        end
    end % for
    
     minRazdalja=minRazdalja+sqrt(R)*randn(1,1); % dodamo še šum na meritev

     % tu saturiraj razdaljo, naj nebo vec kot max doseg
     if(minRazdalja>MAX_DOSEG_SENZORJA)
        minRazdalja=MAX_DOSEG_SENZORJA;
     end
     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function iNextGeneration = resampleParticles(W,nParticles)
    %izberemo glede na ute¡zi delcev
    CDF = cumsum(W)/sum(W);
    iSelect = rand(nParticles,1); % naklju¡cno izbrana ¡stevila
    % indeksi novih delcev
    CDFg=[0;CDF];
    indg=[1;(1:nParticles)'];
    iNextGeneration_float = interp1(CDFg,indg,iSelect,'linear');
    iNextGeneration=round(iNextGeneration_float+0.5); % zaokrožimo indeks navzgor na celo število
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Okolje = DefinirajOkolje
    global Okolje
    % osnovni element je daljica podana z daljico: x1 y1 x2 y2
    Okolje=[ 0 0 2500 0;...         % spodnji rob
             0 0 0 1800;...         % levi rob
             0 1800 2500 1800;...   % zgornji rob
             2500 0 2500 1800;....  % desni rob
             1349 0 1349 275;...                    % spodnja ovira
             2500-1349 1800 2500-1349 1800-275;...  % zgornja ovira
             625 610 625 610+580;...                % leva ovira
             625+1250 610 625+1250 610+580;...      % desna ovira
             625 1800/2 625+1250 1800/2  ];         % sredinska ovira
 
       for i=1:size(Okolje,1)
           line(Okolje(i,[1,3]),Okolje(i,[2,4]),'LineWidth',3,'Color','m'); 
       end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = PopraviCiklicnostKota(a)
    a=atan2(sin(a),cos(a));   % prevedemo kot na obmoèje [-pi,pi]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q]=SimulacijaDejanskegaRobora(q,v,w)
  global Rkolo Lrob Ts
  flag_sum = 1; % stikalo za vkolop ali izkolp šuma
  flag_pri = 0; % stikalo za vkolop ali izkolp pristranskosti
  
  %nimamo toènega podatka o dimenzijah robota Rkolo in Lrob, ki so v resnici
  Rt=Rkolo+0.003*flag_pri;
  Lt=Lrob-0.004*flag_pri;
  % dodatno se dejansko kolo zaradi majnih zdrsov, neravnin, itd... vrti z
  % nekim dodanim šumom
  SIGMA_W=0.3;
  % kotne hitrosti koles glede na vhode z dodanim šumom
  wR=1/(Rkolo)*(v+w*(Lrob)/2)+SIGMA_W*randn(1,1)*flag_sum;
  wL=1/(Rkolo)*(v-w*(Lrob)/2)+SIGMA_W*randn(1,1)*flag_sum;
  
  % dejanska hitrost robota je torej
    vt=Rt/2*(wR+wL);
    wt=Rt/Lt*(wR-wL);
   
 	q(1)=q(1) + Ts*vt*cos( q(3) + Ts*wt/2 );
	q(2)=q(2) + Ts*vt*sin( q(3) + Ts*wt/2 );
    q(3)=q(3) + Ts*wt;
    
    q(3)=PopraviCiklicnostKota(q(3));    % popravi kot q(3)    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DrawRobot(Xr,tip);
global hhh

P=[1 4 4 -4 -4 -1 -1 -4 -4 4 4 1 1;...  % oblika robota
   3 3 4 4 3 3 -3 -3 -4 -4 -3 -3 3]*.015;         

theta = Xr(3); 
Rkolo=[cos(theta) -sin(theta); sin(theta) cos(theta)];
T=repmat([Xr(1);Xr(2)],1,size(P,2)) ;

% toèke obrisa robota transliramo in rotiramo
P=Rkolo*P+T; 
set(hhh(tip),'XData',P(1,:),'YData',P(2,:))   % izris dejanskega robota
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function InitGrafic(xP)
global hhh
figure(10) ;clf ; 
hold on;
zoom on;
title('Localization of diferential drive robot');xlabel('x (m)');ylabel('y (m)');
axis equal
axis([0,2500,0,1800]); 

hhh(1)=plot(0,0,'b','erasemode','xor','LineWidth',2) ;     % dejanski robot 
hhh(2)=plot(0,0,'g','erasemode','xor','LineWidth',2) ;     % robot z odometrijo 

hhh(3)=plot(0,0,'--b','erasemode','none') ;  % dejanska pot
hhh(4)=plot(0,0,'--g','erasemode','none') ;  % ocenjena pot z odometrijo oz. filtrom delcev
hhh(5)=plot(0,0,'.','Color','r','erasemode','xor') ;   % particle
hhh(6)=plot(nan,nan,'LineWidth',1,'Color','r') ; % particle dir
hhh(7)=plot(nan,nan,'LineWidth',2,'Color','c') ; % sensor

%hhh(6)=plot(0,0,'r','erasemode','xor')
%legend('rob','robOdo','pot','odo.','ref.','okolje')
%legend('rob.','pot','ref.')
legend('rob','robEst','path','pathEst','particles')

hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





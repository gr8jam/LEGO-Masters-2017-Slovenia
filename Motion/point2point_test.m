function point2point_test
close all, clear all  % simulation od differential drive
global R L Ts noise

DRAW=1; % enable graphic

Ts=0.033; % sampling time
t=0:Ts:15; % time samples

R=0.04; % wheel radius
L=0.08; % wheel distance

noise = 0;  % 1 - vklopi šum
            % 0 - izklopi šum


q = [-2 0.5 0]';        % inital state
q_odo = q + [0 0 0]';   % suppose inital estimated state is the same as true
q_ref = [1 -0.5 pi]';     % desired final state
q_sen = q + [0 0 0]';   % sensor state

e = [0 0 0]';   % vector of errors
v = 0;          % robot input velocity
w = 0;          % robot input angular velocity

Q=[];Qr=[];Qo=[];E=[];Etrans=[];U=[];Tvzorcenja=[]; EE=[];
tt=0;

%graphic initialisation
global hhh 
if (DRAW) InitGrafic; end

q1 = [-1 0.5 0]';
q2 = [1.5 1  pi]';
q3 = [-1 0.5  pi]';
q4 = [0.5 0  pi/4]';
q5 = [0 0.7  pi]';
q6 = [0 0.3  pi/4]';
q7 = [0 0.1  pi/4]';

q_ref = q2;
q_points = [q1 q2 q3 q4 q5 q6 q7];
idx = 1;

q_points = [q2 q3];

for i=1:length(t)
    
    % Get current robot states
    [q_sen, v_sen, w_sen] = Sensor(q_sen,v,w,noise);
    
    %%%%%% determine robot inputs
    [v,w] = ContolerPosition(q_ref, q_sen, w_sen);
    
%     % error calculation
%     e(1:2) = q_ref(1:2) - q_sen(1:2);
%     q_ref(3) = atan2((q_ref(2) - q_sen(2)), (q_ref(1) - q_sen(1)));
%     e(3) = CorrectAngle(q_ref(3) - q_sen(3));
%     
%     % orientation controler
% %     K = 3;
% %     w = K*e(3);             % P controler
%     K1 = 3;
%     K2 = 0.3;
%     w = K1*e(3) - K2*w_sen; % PD controler
%     w = ramp_omega(w);
%     
%     % position controler
%     e_d = sqrt(e(1)^2 + e(2)^2);
%     % G = 1 - abs(e(3))/pi;
% %     G = abs(cos(e(3)));
%     G = exp(-5*abs(e(3)));
% %     if (e_d < 0.01) 
% %         idx = idx + 1;
% %         if idx > 7
% %             idx = 7;
% %         end
% %         q_ref = q_points(:,idx);
% %         
% %     else
% %         K3 = 1;
% %         v = G * K3 * e_d;
% %     end
%     K3 = 10;
%     v = G * K3 * e_d;
%     v = ramp_velocity(v);
    
    
    % robot motion (includes optional noise and modelling error)
    [q]=SimulateRobotMotion(q,v,w);
    
    
    % store values
    Q=[Q;q']; Qo=[Qo;q_sen']; Qr=[Qr;q_ref']; U=[U;[v, w]];  
    Tvzorcenja=[Tvzorcenja; tt];
    tt=tt+Ts;
    
   if (DRAW)
        DrawRobot(q',1);     % seccond parameter: robot=1, odometry=2
        DrawRobot(q_sen',2); % seccond parameter: robot=1, odometry=2
        set(hhh(3),'XData',Q(:,1),'YData',Q(:,2));  % draw path
        set(hhh(4),'XData',Qo(:,1),'YData',Qo(:,2));  % draw odometry
        set(hhh(5),'XData',Qr(:,1),'YData',Qr(:,2));  % draw reference path

        pause(0.03);t
        drawnow;        
   end
   
end

figure

plot(Q(:,1),Q(:,2),Qo(:,1),Qo(:,2),'--')
xlabel('x [m]'),ylabel('y [m]')
figure
plot(Tvzorcenja,U(:,1),Tvzorcenja,U(:,2),'--')
xlabel('t [s]'),ylabel('v [m/s], \omega [rad/s]'),legend('v','\omega'),



end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Functions   %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = CorrectAngle(a)
    a=atan2(sin(a),cos(a));   % put in range [-pi,pi]
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q_sen, v_sen, w_sen] = Sensor(q,v,w,noise)
    global R L Ts
    % suppose that we do not know exact robot parametrs R and L, they
    % actually are:
    Rt=R+0.001*noise;
    Lt=L-0.002*noise;
    % wheels rotation include also noise due to slip, different groung
    % surface,...
    SIGMA_W=0.4*noise;
    % wheel velocities
    wR=1/(R)*(v+w*(L)/2)+SIGMA_W*randn(1,1);
    wL=1/(R)*(v-w*(L)/2)+SIGMA_W*randn(1,1);
  
    % true robot velocity
    vt=Rt/2*(wR+wL);
    wt=Rt/Lt*(wR-wL);
    
    v_sen = vt;
    w_sen = wt;
   
 	q(1)=q(1) + Ts*vt*cos( q(3) + Ts*wt/2 );
	q(2)=q(2) + Ts*vt*sin( q(3) + Ts*wt/2 );
    q(3)=q(3) + Ts*wt;
    
    q(3)=CorrectAngle(q(3)); 
    
    q_sen = q;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q]=SimulateRobotMotion(q,v,w)
  global R L Ts
  noise = 0;
  % suppose that we do not know exact robot parametrs R and L, they
  % actually are:
  Rt=R+0.001*noise;
  Lt=L-0.002*noise;
  % wheels rotation include also noise due to slip, different groung
  % surface,...
  SIGMA_W=0.4*noise;
  % wheel velocities
  wR=1/(R)*(v+w*(L)/2)+SIGMA_W*randn(1,1);
  wL=1/(R)*(v-w*(L)/2)+SIGMA_W*randn(1,1);
  
  % true robot velocity
    vt=Rt/2*(wR+wL);
    wt=Rt/Lt*(wR-wL);
   
 	q(1)=q(1) + Ts*vt*cos( q(3) + Ts*wt/2 );
	q(2)=q(2) + Ts*vt*sin( q(3) + Ts*wt/2 );
    q(3)=q(3) + Ts*wt;
    
    q(3)=CorrectAngle(q(3));       
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DrawRobot(Xr,tip)
global hhh

P=[1 4 4 -4 -4 -1 -1 -4 -4 4 4 1 1;...  % robot shape
   3 3 4 4 3 3 -3 -3 -4 -4 -3 -3 3]*.01;         

theta = Xr(3); 
R=[cos(theta) -sin(theta); sin(theta) cos(theta)];
T=repmat([Xr(1);Xr(2)],1,size(P,2)) ;

% rotate and translate robot shape points
P=R*P+T; 
set(hhh(tip),'XData',P(1,:),'YData',P(2,:))   % draw the robot
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%=============================================================================
% LocalRoboInit
% Local function to initialize the robobrc animation.  If the animation
% window already exists, it is brought to the front.  Otherwise, a new
% figure window is created.
%=============================================================================
%
function InitGrafic()
global hhh
figure(10) ;clf ; 
hold on;

zoom on;
title('Robot with differential drive');xlabel('x (m)');ylabel('y (m)');

axis([-1 2 -1 2]); 
axis equal

%plot(znacke(1,:),znacke(2,:),'b*')
hhh(1)=plot(0,0,'b','erasemode','xor') ;     % true robot 
hhh(2)=plot(0,0,'g','erasemode','xor') ;     % odometry estimated robot 

hhh(3)=plot(0,0,'--b','erasemode','none') ;  % true path
hhh(4)=plot(0,0,'--g','erasemode','none') ;  % odometry estimated path
hhh(5)=plot(0,0,':r','erasemode','none') ;   % reference path 


legend('rob','robOdo','path','odometry','reference')

hold off;
end


function qMean = ParticleFilter(u)

global Robot Ts


% noise
Q=diag([3^2,0.2^2])*10; % variance of actuator noise (translational velocity, angular velocity)
R=diag([0.1^2])*1;        % variance of distance sensor noise

% initialize particels
nParticles=400;

% all particles have equal weights
W = ones(nParticles,1)/nParticles;


%% Pridobi meritev
zTrueL = Robot.idxL;
zTrueR = Robot.idxR;
% zTrueHeading = TrueRobot.q(3);


%% Korekcija delcev
for p = 1:nParticles
    % ocenjena meritev za vsak delec
    
%      zHeading = Robot.xP(3,p);
%     Innov = zTrueHeading-zHeading; %doloèimo inovacijo
% 
%     % doloèimo uteži delcev (njihovo verjetnost)
%     RR=eye(1)*(3*pi/180)^2; % kovarianèna matrika meritve
%     W(p) = exp(-0.5*Innov'*inv(RR)*Innov)+0.0001;
% 
    try
       [zL, zR] = SimulationRGB(Robot.xP(:,p));
    catch exception
       fprintf('Error: Simulation od %i particle in PF', p);
    end
    
%     
    if (zTrueL == zL) && (zTrueR == zR)
        W(p) = W(p)*1;
    elseif (zTrueL == zL) || (zTrueR == zR)
        W(p) = W(p)*0.7;
    else
        W(p) = W(p)*0.05;
    end
    
    
%     z = [SensorDistance(-2*pi/3,Robot.xP(:,p),0);  % returns distance to the obstacles in three directions, includes also noise with variance R
%          SensorDistance(      0,Robot.xP(:,p),0);
%          SensorDistance( 2*pi/3,Robot.xP(:,p),0)];
% 
%     Innov = zTrue-z; %doloèimo inovacijo
% 
%     % doloèimo uteži delcev (njihovo verjetnost)
%     RR=eye(3)*R; % kovarianèna matrika meritve
%     W(p) = exp(-0.5*Innov'*inv(RR)*Innov)+0.0001;
end

%% Ponovno doloèit delce
iNextGeneration=resampleParticles(W,nParticles);
Robot.xP = Robot.xP(:,iNextGeneration);

%% Oceni dejanska stanja robota
% ocena stanja je povpreèje delcev
x = mean(Robot.xP,2);
x(3) = wrapToPi(x(3));
% Particle filter (PF) estimate is obtained by the avarage od praticle states 
qMean = x;     % here write current pose estimate from PF 


%% Predikcija delcev
% Naredi predikcijo in poèakaj na novo meritev
for p = 1:nParticles
    un = u + sqrt(Q)*randn(2,1)*1 ; % delce premaknemo s šumom modela
    Robot.xP(:,p) = Robot.xP(:,p) + Ts*[ un(1)*cos(Robot.xP(3,p)); ...
                                         un(1)*sin(Robot.xP(3,p)); ...
                                         un(2) ] ;
    Robot.xP(3,p) = wrapToPi(Robot.xP(3,p));
end

Robot.xP((Robot.xP(1:2, :) < 1)) = 1;
Robot.xP((Robot.xP(1, :) > 2500)) = 2500;
Robot.xP((Robot.xP(2, :) > 1800)) = 1800;


end
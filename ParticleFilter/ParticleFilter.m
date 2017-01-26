function qMean = ParticleFilter(u)

global TrueRobot Robot Ts

persistent WCET
if isempty(WCET)
    WCET = 0;
end
start = toc;

% noise
Q=diag([5^2,0.5^2]); % variance of actuator noise (translational velocity, angular velocity)
R=diag([0.1^2])*1;        % variance of distance sensor noise

% all particles have equal weights
W = ones(Robot.PF.nParticles,1)/Robot.PF.nParticles;

%% Pridobi meritev
zTrueL = Robot.idxL;
zTrueR = Robot.idxR;
% zTrueHeading = TrueRobot.q(3);

badParticleIdx = zeros(600,1);
goodParticleIdx = zeros(600,1);
greatParticleIdx = zeros(600,1);

badIdxCnt = 0;
goodIdxCnt = 0;
greatIdxCnt = 0;


%% Korekcija delcev
for p = 1:Robot.PF.nParticles
    % ocenjena meritev za vsak delec
    
%      zHeading = Robot.xP(3,p);
%     Innov = zTrueHeading-zHeading; %doloèimo inovacijo
% 
%     % doloèimo uteži delcev (njihovo verjetnost)
%     RR=eye(1)*(3*pi/180)^2; % kovarianèna matrika meritve
%     W(p) = exp(-0.5*Innov'*inv(RR)*Innov)+0.0001;
% 
    try
       [zL, zR] = SimulationRGB(Robot.PF.xP(:,p));
    catch exception
       fprintf('Error: Simulation od %i particle in PF \n', p);
    end
    
    
    if (zTrueL == zL) && (zTrueR == zR)
        W(p) = W(p)*1;
        greatIdxCnt = greatIdxCnt +1;
        greatParticleIdx(greatIdxCnt) = p;
    elseif (zTrueL == zL) || (zTrueR == zR)
        W(p) = W(p)*1;
        goodIdxCnt = goodIdxCnt +1;
        goodParticleIdx(goodIdxCnt) = p;
    else
        W(p) = W(p)*1;
        badIdxCnt = badIdxCnt +1;
        badParticleIdx(badIdxCnt) = p;
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
% iNextGeneration=resampleParticles(W,nParticles);
% Robot.xP = Robot.xP(:,iNextGeneration);

% iNextGeneration=resampleParticles(W,length(badParticleIdx));
% Robot.xP = Robot.xP(:,iNextGeneration);
% 



for idx = 1:badIdxCnt
    if  greatIdxCnt > 0
        newIdx = greatParticleIdx(randi(greatIdxCnt));
    elseif goodIdxCnt > 0
        newIdx = goodParticleIdx(randi(goodIdxCnt));
    else
        break;
%         ParticleFilterInit;
    end
    
    Robot.PF.xP(1:2,badParticleIdx(idx)) = Robot.PF.xP(1:2, newIdx) + [sin(TrueRobot.q(3)); -cos(TrueRobot.q(3))] .* randi([-3 3],2,1);
    Robot.PF.xP(3,badParticleIdx(idx)) = Robot.PF.xP(3, newIdx);
%     Robot.xP(3,badParticleIdx(idx)) = TrueRobot.q(3);
end

for idx = 1:4:goodIdxCnt
    if greatIdxCnt > 0
        newIdx = greatParticleIdx(randi(greatIdxCnt));
        Robot.PF.xP(1:2,goodParticleIdx(idx)) = Robot.PF.xP(1:2, newIdx) + [sin(TrueRobot.q(3)); -cos(TrueRobot.q(3))] .* randi([-3 3],2,1);
        Robot.PF.xP(3,goodParticleIdx(idx)) = Robot.PF.xP(3, newIdx);
%         Robot.xP(3,goodParticleIdx(idx)) = TrueRobot.q(3);
    end
end

% iNextGeneration=resampleParticles(W,nParticles);
% Robot.xP = Robot.xP(:,iNextGeneration);


        
%% Oceni dejanska stanja robota
% Odpravi cikliènost kota
countNegativePi = 0;
countPositivePi = 0;

for p = 1:Robot.PF.nParticles
    if Robot.PF.xP(3,p) < -3*pi/4;
        countNegativePi = countNegativePi + 1;
    elseif Robot.PF.xP(3,p) > 3*pi/4;
        countPositivePi = countPositivePi + 1;
    end
end

if (countNegativePi > 0) && (countPositivePi > 0)
    for p = 1:Robot.PF.nParticles
        if Robot.PF.xP(3,p) < -3*pi/4;
            Robot.PF.xP(3,p) = Robot.PF.xP(3,p) + 2*pi;
        end
    end
end

% ocena stanja je povpreèje delcev
x = mean(Robot.PF.xP,2);
x(3) = wrapToPi(x(3));
% Particle filter (PF) estimate is obtained by the avarage od praticle states 
qMean = x;     % here write current pose estimate from PF 


%% Predikcija delcev
% Naredi predikcijo in poèakaj na novo meritev
% c = cos(Robot.PF.xP(3,p));
% s = sin(Robot.PF.xP(3,p));
for p = 1:Robot.PF.nParticles
    un = u + sqrt(Q)*randn(2,1)*1 ; % delce premaknemo s šumom modela
    Robot.PF.xP(:,p) = Robot.PF.xP(:,p) + Ts*[ un(1)*cos(Robot.PF.xP(3,p)); ...
                                               un(1)*sin(Robot.PF.xP(3,p)); ...
                                               un(2) ] ;
    Robot.PF.xP(3,p) = wrapToPi(Robot.PF.xP(3,p));
end

Robot.PF.xP((Robot.PF.xP(1:2, :) < 1)) = 1;
Robot.PF.xP((Robot.PF.xP(1, :) > 2500)) = 2500;
Robot.PF.xP((Robot.PF.xP(2, :) > 1800)) = 1800;


finish = toc - start;
if WCET < finish
    WCET = finish;
end

end
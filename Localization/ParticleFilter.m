function ParticleFilter()

global Ts 
global PF 
global SenRGB
global v w

persistent WCET
if isempty(WCET)
    WCET = 0;
end
start = toc;

% noise
Q=diag([5^2,0.5^2]); % variance of actuator noise (translational velocity, angular velocity)
R=diag([0.1^2])*1;        % variance of distance sensor noise


%% Predikcija delcev
% Naredi predikcijo in poèakaj na novo meritev
% c = cos(PF.xP(3,p));
% s = sin(PF.xP(3,p));
for p = 1:PF.nParticles
    un = [v w]' + sqrt(Q)*randn(2,1)*1 ; % delce premaknemo s šumom modela
    PF.xParticles(:,p) = PF.xParticles(:,p) + Ts*[ un(1)*cos(PF.xParticles(3,p)); ...
                                               un(1)*sin(PF.xParticles(3,p)); ...
                                               un(2) ] ;
    PF.xParticles(3,p) = wrapToPi(PF.xParticles(3,p));
end

PF.xParticles((PF.xParticles(1:2, :) < 1)) = 1;
PF.xParticles((PF.xParticles(1, :) > 2500)) = 2500;
PF.xParticles((PF.xParticles(2, :) > 1800)) = 1800;


finish = toc - start;
if WCET < finish
    WCET = finish;
end


%% Pridobi meritev
zTrueL = SenRGB.Left.idx;
zTrueR = SenRGB.Right.idx;

% zTrueL = Robot.idxL;
% zTrueR = Robot.idxR;
% zTrueHeading = TrueRobot.q(3);

badParticleIdx = zeros(600,1);
goodParticleIdx = zeros(600,1);
greatParticleIdx = zeros(600,1);

badIdxCnt = 0;
goodIdxCnt = 0;
greatIdxCnt = 0;


%% Korekcija delcev
for p = 1:PF.nParticles
    % ocenjena meritev za vsak delec
    
%      zHeading = Robot.xP(3,p);
%     Innov = zTrueHeading-zHeading; %doloèimo inovacijo
% 
%     % doloèimo uteži delcev (njihovo verjetnost)
%     RR=eye(1)*(3*pi/180)^2; % kovarianèna matrika meritve
%     W(p) = exp(-0.5*Innov'*inv(RR)*Innov)+0.0001;
% 
    try
       [zL, zR] = SimulationRGB(PF.xParticles(1,p),PF.xParticles(2,p),PF.xParticles(3,p));
    catch exception
       fprintf('Error: Simulation od %i particle in PF \n', p);
    end
    
    
    if (zTrueL == zL) && (zTrueR == zR)
        greatIdxCnt = greatIdxCnt +1;
        greatParticleIdx(greatIdxCnt) = p;
    elseif (zTrueL == zL) || (zTrueR == zR)
        goodIdxCnt = goodIdxCnt +1;
        goodParticleIdx(goodIdxCnt) = p;
    else
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
    
    PF.xParticles(1,badParticleIdx(idx)) = PF.xParticles(1, newIdx) + randi([-5 5]);
    PF.xParticles(2,badParticleIdx(idx)) = PF.xParticles(2, newIdx) + randi([-5 5]);
    PF.xParticles(3,badParticleIdx(idx)) = PF.xParticles(3, newIdx);
end

for idx = 1:8:goodIdxCnt
    if greatIdxCnt > 0
        newIdx = greatParticleIdx(randi(greatIdxCnt));
        PF.xParticles(1,goodParticleIdx(idx)) = PF.xParticles(1, newIdx) + randi([-5 5]);
        PF.xParticles(2,goodParticleIdx(idx)) = PF.xParticles(2, newIdx) + randi([-5 5]);
        PF.xParticles(3,goodParticleIdx(idx)) = PF.xParticles(3, newIdx);
    end
end

        
%% Oceni dejanska stanja robota
% Odpravi cikliènost kota
countNegativePi = 0;
countPositivePi = 0;

for p = 1:PF.nParticles
    if PF.xParticles(3,p) < -3*pi/4;
        countNegativePi = countNegativePi + 1;
    elseif PF.xParticles(3,p) > 3*pi/4;
        countPositivePi = countPositivePi + 1;
    end
end

if (countNegativePi > 0) && (countPositivePi > 0)
    for p = 1:PF.nParticles
        if PF.xParticles(3,p) < -3*pi/4;
            PF.xParticles(3,p) = PF.xParticles(3,p) + 2*pi;
        end
    end
end

% ocena stanja je povpreèje delcev
GetPoseFromParticleAvrage();


end




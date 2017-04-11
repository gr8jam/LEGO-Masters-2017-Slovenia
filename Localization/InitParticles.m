function InitParticles()

global Nodes 
global PF 
global SenRGB


idxL = SenRGB.Left.idx;
idxR = SenRGB.Right.idx;

% if (idxL ~= idxL2) || (idxR ~= idxR2)
%     idxL2 = 1;
% end


%% Select particles as nodes
% for px = 1:PF.nParticles
%     
%     p = mod(px,96);
% %     if (p == 40)
% %         p = 41;
% %     end
%     if (p == 0)
%         p = 96;
%     end
%     
%     noise = 25;
%     
%     PF.xParticles(1,p) = Nodes(p).x + randi([noise noise]);
%     PF.xParticles(2,p) = Nodes(p).y + randi([-noise noise]);
%     PF.xParticles(3,p) = Nodes(p).fi + randi([-noise noise])*pi/180;
%     PF.xParticles(3,p) = wrapToPi(PF.xParticles(3,p));
% 
% %     p2 = p+1;
% %     PF.xParticles(1,p2) = Nodes(p2).x + randi([noise noise]);
% %     PF.xParticles(2,p2) = Nodes(p2).y + randi([-noise noise]);
% %     PF.xParticles(3,p2) = Nodes(p2).fi + randi([-noise noise])*pi/180;
% %     PF.xParticles(3,p2) = wrapToPi(PF.xParticles(3,p2));
% end


%% Select Random Nodes and dedicad them to particles
for p = 1:PF.nParticles   
    
    cnt = 0;
    not_done = true;
    while not_done
        cnt = cnt +1;
        idxNode = randi(96);
%         idxNode = 81;
%         if (idxNode == 91)
%             idxNode = 41;
%         end
        
        noise = 25;
        PF.xParticles(1,p) = Nodes(idxNode).x + randi([-noise noise]);
        PF.xParticles(2,p) = Nodes(idxNode).y + randi([-noise noise]);
        PF.xParticles(3,p) = Nodes(idxNode).fi + randi([-noise noise]./5)*pi/180;
        PF.xParticles(3,p) = wrapToPi(PF.xParticles(3,p));
        
        [idxLxP, idxRxP] = SimulationRGB(PF.xParticles(1,p),PF.xParticles(2,p),PF.xParticles(3,p));
        if ((idxL == idxLxP) && (idxR == idxRxP))  
            not_done = false;
        end
        
        if (cnt > 10000) 
            error('PF could not find matching particle! \n');
        end
    end
end

%%
% xP = repmat(q0,1,nParticles)+ diag([300,300,2*pi] )*rand(3,nParticles) - ([300,300,2*pi]'*.5*ones(1,nParticles)); % inicicalizacija delcev

% xP = rand(3,nParticles);
% xP(1,:) = xP(1,:) * 2499 + 1;
% xP(2,:) = xP(2,:) * 1799 + 1;
% xP(3,:) = xP(3,:) * 2*pi - pi;



GetPoseFromParticleAvrage();

% xMean = 0;
% yMean = 0;
% fiMean = 0;
% for i=1:PF.nParticles
%     xMean = xMean + PF.xParticles(1,i);
%     yMean = yMean + PF.xParticles(2,i);
%     fiMean = fiMean + wrapToPi(PF.xParticles(3,i));
% end
% 
% PF.x = xMean/PF.nParticles;
% PF.y = yMean/PF.nParticles;
% PF.fi = fiMean/PF.nParticles;


end




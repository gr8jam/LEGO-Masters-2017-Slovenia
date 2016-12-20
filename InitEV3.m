function Robot = InitEV3(q0)
nParticles=600;

load('Polygon_map')



xP = zeros(3,nParticles);
for p = 1:nParticles
    
    not_done = true;
    while not_done
        xP(:,p) = rand(3,1);
        xP(1,p) = int64(xP(1,p) * 2499 + 1);
        xP(2,p) = int64(xP(2,p) * 1799 + 1);
        
        if (colors(q0(2),q0(1)) == colors(xP(2,p),xP(1,p))) 
            not_done = false;
        end
    end
%     xP(3,p) = xP(3,p) * 2*pi - pi;
    xP(3,p) = q0(3);
    
    
end
% xP = repmat(q0,1,nParticles)+ diag([300,300,2*pi] )*rand(3,nParticles) - ([300,300,2*pi]'*.5*ones(1,nParticles)); % inicicalizacija delcev

% xP = rand(3,nParticles);
% xP(1,:) = xP(1,:) * 2499 + 1;
% xP(2,:) = xP(2,:) * 1799 + 1;
% xP(3,:) = xP(3,:) * 2*pi - pi;

qMean = mean(xP,2);

Robot = struct('R', 0.05,...
               'L', 0.15,...
               'q', qMean, ...
               'xP', xP, ...
               'hsv1', hsv1,...
               'hsv2', hsv2,...
               'dist', dist,...
               'fi', fi);      
end




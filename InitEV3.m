function Robot = InitEV3(q0)
nParticles=300;
xP = repmat(q0,1,nParticles)+ diag([1,1,pi/2]*.5) * randn(3,nParticles); % inicicalizacija delcev

Robot = struct('R', 0.05,...
               'L', 0.15,...
               'q', q0, ...
               'xP', xP);      
end




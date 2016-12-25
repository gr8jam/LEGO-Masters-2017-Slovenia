function [q] = Localization(v,w)
global Ts Robot

persistent first
if isempty(first)
    first = true;
end

if first
    InitParticleFilter();
    first = false;
    fprintf('PF init complete \n')
else
    q = Robot.q + [v v 0]'*Ts;
    
end

q = Robot.q + [v 0 0]'*Ts;
% q = Robot.q + [v 0 0]'*Ts;

end
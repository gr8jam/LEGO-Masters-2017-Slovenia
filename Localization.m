function [q] = Localization(v,w)
global Robot

q = [0 0 0]';
Init = 1;
Operational = 2;

persistent state
if isempty(state)
    state = Init;
end

switch state
    case Init
        Robot.PF = ParticleFilterInit();
        state = Operational;
        fprintf('PF init complete. \n')
        
    case Operational
        
        q = ParticleFilter([v w]');
        
        reInit = ParticleFilterEstimation();
        if reInit
            state = Init;
        end
        
    otherwise
        error('PF in unknown state! \n')
end




end
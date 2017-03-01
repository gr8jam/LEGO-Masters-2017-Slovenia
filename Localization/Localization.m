function [q] = Localization(v,w)
global Robot LocalizationState PF
DEBUG = true;

q = [0 0 0]';

% LocalizationState = 'Init';
% LocalizationState = 'Reinit';
% LocalizationState = 'Operational';

switch LocalizationState
    case 'Init'
        InitParticles();
        LocalizationState = 'Operational';
        PF.Estimate = 'Searching';
        
        if (DEBUG) fprintf('PF init complete. \n'); end;
        
    case 'Reinit'
        InitParticles();
        LocalizationState = 'Operational';
        PF.Estimate = 'Searching';
        
        if (DEBUG) fprintf('PF reinit complete. \n'); end;
        
    case 'Operational'
        Robot.q = ParticleFilter([v w]');
        PF.Estimate = ParticleFilterEstimation();
        
        switch PF.Estimate
            case 'Working'
                LocalizationState = 'Operational';
                
            case 'Searching'
                LocalizationState = 'Operational';
                
            case 'Error'
                LocalizationState = 'Reinit';
                error('PF Estimation in state "Error"! \n')
            otherwise 
                error('PF Estimation in unknown state! \n')
        end
              
    otherwise
        error('PF in unknown state! \n')
end

q = Robot.q;

end



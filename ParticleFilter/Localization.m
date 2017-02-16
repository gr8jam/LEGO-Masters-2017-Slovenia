function [q] = Localization(v,w)
global Robot LocalizationState
DEBUG = true;

q = [0 0 0]';

% LocalizationState = 'Init';
% LocalizationState = 'Reinit';
% LocalizationState = 'Operational';

switch LocalizationState
    case 'Init'
        Robot.PF = ParticleFilterInit();
        LocalizationState = 'Operational';
        Robot.PF.Estimate = 'Searching';
        
        if (DEBUG) fprintf('PF init complete. \n'); end;
        
    case 'Reinit'
        Robot.PF = ParticleFilterInit();
        LocalizationState = 'Operational';
        Robot.PF.Estimate = 'Searching';
        
        if (DEBUG) fprintf('PF reinit complete. \n'); end;
        
    case 'Operational'
        Robot.q = ParticleFilter([v w]');
        Robot.PF.Estimate = ParticleFilterEstimation();
        
        switch Robot.PF.Estimate
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



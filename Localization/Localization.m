function Localization(v,w)
global Robot PF
DEBUG = true;

% State = 'Init';
% State = 'Reinit';
% State = 'Operational';

switch PF.State
    case 'Init'
        InitParticles();
        PF.State = 'Operational';
        PF.Estimate = 'Searching';
        
        if (DEBUG) fprintf('PF init complete. \n'); end;
        
    case 'Reinit'
        InitParticles();
        PF.State = 'Operational';
        PF.Estimate = 'Searching';
        
        if (DEBUG) fprintf('PF reinit complete. \n'); end;
        
    case 'Operational'
        ParticleFilter([v w]');
        ParticleFilterEstimation();
        
        switch PF.Estimate
            case 'Working'
                PF.State = 'Operational';
                
            case 'Searching'
                PF.State = 'Operational';
                
            case 'Error'
                PF.State = 'Reinit';
                error('PF Estimation in state "Error"! \n')
            otherwise 
                error('PF Estimation in unknown state! \n')
        end
              
    otherwise
        error('PF in unknown state! \n')
end


end



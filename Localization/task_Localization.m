function task_Localization()
global PF SenRGB
DEBUG = true;

% State = 'Init';
% State = 'Reinit';
% State = 'Operational';


switch PF.State
    case 'Init'
        InitParticles();
        PF.State = 'Operational';
        
        if (DEBUG) fprintf('PF init complete. \n'); end;
        
    case 'Reinit'
        if SenRGB.Right.Changed
            InitParticles();
            PF.Flag_Reinit = false;
            PF.State = 'Operational';
            if (DEBUG) fprintf('PF reinit complete. \n'); end;
        end
        
        
    case 'Operational'
        ParticleFilter();
        ParticleFilterEstimation();
        
        if PF.Flag_Reinit
            PF.State = 'Reinit';
        end
%         switch PF.Estimate
%             case 'Working'
%                 PF.State = 'Operational';
%                 
%             case 'Searching'
%                 PF.State = 'Operational';
%                 
%             case 'Error'
%                 PF.State = 'Reinit';
% %                 error('PF Estimation in state "Error"! \n')
%             otherwise 
%                 error('PF Estimation in unknown state! \n')
%         end
              
    otherwise
        error('PF in unknown state! \n')
end


end



function PF = InitParticleFilter()

PF = struct('State', 'Init',...
            'Estimate', 'Searching',...
            'nParticles', 300,...
            'xParticles', zeros(3, 100),...
            'x', 300,...
            'y', 300,...
            'fi', 300);

end
        
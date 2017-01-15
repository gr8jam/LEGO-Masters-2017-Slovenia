function Robot = InitEV3(q0)


% Get this data from sensors
hsvL = [0 0 0];
hsvR = [0 0 0];
idxL = 1;
idxR = 1;
posL = [0 0]';
posR = [0 0]';
dist = 1;
fi = 0;

Motion = struct('inc'        , 0,...
                'Ptr'        , 0,...
                'F_Test'     , 0,...
                'tiTest'     , 0,...
                'SwitchStart', 0,...
                'SwitchLeft' , 0,...
                'SwitchRight', 0,...
                'rkot'       , [],...
                'dkot'       , [],...
                'F_t'        , 0,...
                'tDly'       , 0,...
                'sensL'      , 0,...
                'sensD'      , 0,...
                'ww'         , 0,...
                'vv'         , 0,...
                'Localisation',0,...
                'Odo'        , 0);

PF = struct('nParticles', 100,...
            'xP', zeros(3, 100));

Robot = struct('R', 0.05,...
               'L', 0.15,...
               'q', q0, ...
               'xP', [0 0 0]', ...
               'hsvL', hsvL,...
               'hsvR', hsvR,...
               'idxL', idxL,...
               'idxR', idxR,...
               'posL', posL,...
               'posR', posR,...
               'dist', dist,...
               'fi', fi,...
               'PF', PF,...
               'Motion', Motion); 
           


DriverRGB();
DriverGyro();
DriverDist();
ParticleFilterInit();

end




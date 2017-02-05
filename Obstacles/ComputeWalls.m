% osnovni element je daljica podana z daljico: x1 y1 x2 y2
Walls = [    0 0 2500 0;...         % spodnji rob
             0 0 0 1800;...         % levi rob
             0 1800 2500 1800;...   % zgornji rob
             2500 0 2500 1800;....  % desni rob
             1349 0 1349 275;...                    % spodnja ovira
             2500-1349 1800 2500-1349 1800-275;...  % zgornja ovira
             625 610 625 610+580;...                % leva ovira
             625+1250 610 625+1250 610+580;...      % desna ovira
             625 1800/2 625+1250 1800/2  ];         % sredinska ovira
         
save('Walls.mat', 'Walls'); 


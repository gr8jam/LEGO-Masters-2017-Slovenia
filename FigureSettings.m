function FigureSettings(fig,user)
%% input parameter user has two options
% 1 - for matej
% 2 - for peter

switch user
    case 'matej'
       FigureSettings_Matej(fig);
    case 'm'
        FigureSettings_Matej(fig);
    case 'mato'
        FigureSettings_Matej(fig);
        
        
    case 'peter'
        FigureSettings_Peter(fig)
    case 'p'
        FigureSettings_Peter(fig);  
    case 'pero'
        FigureSettings_Peter(fig);  
    otherwise
        error('Invalid input parameter \n');
end

% Apperance setings
title('Localization of diferential drive robot');
xlabel('x (mm)');
ylabel('y (mm)');
axis equal
axis([-20 2800 -20 1820]);
end


function FigureSettings_Matej(fig)
screensize = get( groot, 'Screensize' );
W_screen = screensize(3);
H_screen = screensize(4);
W = W_screen/2;
H = 18/25 * W;

set(fig, 'Position', [0 H_screen-H-100 W H]); %% matej
% set(fig, 'Position', [0 170 25*35 18*35]);
end

function FigureSettings_Peter(fig)
set(fig, 'Position', [-1600 20 25*60 18*60]);  %% pero
end

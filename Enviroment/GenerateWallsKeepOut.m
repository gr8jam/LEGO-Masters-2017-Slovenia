function GenerateWallsKeepOut
clear all;
close all;

GenerateWalls();

d = 55;

Walls = [];
load('Walls.mat');

WallsKeepOut = Walls(1:4,:) +   [+d +d -d +d;
                                 +d +d +d -d;
                                 +d -d -d -d;
                                 -d +d -d -d];

% KeepOutWalls =    [0+d 0+d 2500-d 0+d;          % rob spodi
%                    2500-d 0+d 2500-d 1800-d;    % rob desno
%                    2500-d 1800-d 0+d 1800-d;    % rob zgori
%                    0+d 1800-d 0+d 0+d];         % rob levo


verL = GetOctagonVertices(Walls(5,3),Walls(5,4),d); % low
verH = GetOctagonVertices(Walls(6,3),Walls(6,4),d); % high

WallsKeepOut= [WallsKeepOut;
               Walls(5,1)+d Walls(5,2)+d verL(1,:);
               verL(1,:) verL(2,:);
               verL(2,:) verL(3,:);
               verL(3,:) verL(4,:);
               verL(4,:) Walls(5,1)-d Walls(5,2)+d;

               Walls(6,1)-d Walls(6,2)-d verH(5,:);
               verH(5,:) verH(6,:);
               verH(6,:) verH(7,:);
               verH(7,:) verH(8,:);
               verH(8,:) Walls(6,1)+d Walls(6,2)-d;
               ];

verLH = GetOctagonVertices(Walls(7,3),Walls(7,4),d); % left high
verLL = GetOctagonVertices(Walls(7,1),Walls(7,1),d); % left low
verRH = GetOctagonVertices(Walls(8,3),Walls(7,4),d); % right high
verRL = GetOctagonVertices(Walls(8,1),Walls(7,1),d); % right low

WallsKeepOut= [WallsKeepOut;
               verLH(1,:) verLH(2,:);
               verLH(2,:) verLH(3,:);
               verLH(3,:) verLH(4,:);
               verLH(4,:) verLL(5,:);
               verLL(5,:) verLL(6,:);
               verLL(6,:) verLL(7,:);
               verLL(7,:) verLL(8,:);

               verLL(8,:) Walls(9,1)+d Walls(9,2)-d;
               Walls(9,1)+d Walls(9,2)-d Walls(9,3)-d Walls(9,4)-d;
               Walls(9,3)-d Walls(9,4)-d verRL(5,:);

               verRL(5,:) verRL(6,:);
               verRL(6,:) verRL(7,:);
               verRL(7,:) verRL(8,:);
               verRL(8,:) verRH(1,:);
               verRH(1,:) verRH(2,:);
               verRH(2,:) verRH(3,:);
               verRH(3,:) verRH(4,:);

               verRH(4,:) Walls(9,3)-d Walls(9,4)+d;
               Walls(9,3)-d Walls(9,4)+d Walls(9,1)+d Walls(9,2)+d;
               Walls(9,1)+d Walls(9,2)+d verLH(1,:);

               ];

save('WallsKeepOut.mat' ,'WallsKeepOut');

end

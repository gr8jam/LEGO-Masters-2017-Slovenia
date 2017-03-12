function TrueKeepOut = InitTrueKeepOut(TrueWalls, TrueObstacleCenters)

d = 50;

%% Walls
TrueKeepOut = TrueWalls(1:4,:) +[+d +d -d +d;
                                 +d +d +d -d;
                                 +d -d -d -d;
                                 -d +d -d -d];

verL = GetOctagonVertices(TrueWalls(5,3),TrueWalls(5,4),d); % low
verH = GetOctagonVertices(TrueWalls(6,3),TrueWalls(6,4),d); % high

TrueKeepOut = [TrueKeepOut;
           TrueWalls(5,1)+d TrueWalls(5,2)+d verL(1,:);
           verL(1,:) verL(2,:);
           verL(2,:) verL(3,:);
           verL(3,:) verL(4,:);
           verL(4,:) TrueWalls(5,1)-d TrueWalls(5,2)+d;
           
           TrueWalls(6,1)-d TrueWalls(6,2)-d verH(5,:);
           verH(5,:) verH(6,:);
           verH(6,:) verH(7,:);
           verH(7,:) verH(8,:);
           verH(8,:) TrueWalls(6,1)+d TrueWalls(6,2)-d;
           ];

verLH = GetOctagonVertices(TrueWalls(7,3),TrueWalls(7,4),d); % left high
verLL = GetOctagonVertices(TrueWalls(7,1),TrueWalls(7,1),d); % left low
verRH = GetOctagonVertices(TrueWalls(8,3),TrueWalls(7,4),d); % right high
verRL = GetOctagonVertices(TrueWalls(8,1),TrueWalls(7,1),d); % right low

TrueKeepOut = [TrueKeepOut;
           verLH(1,:) verLH(2,:);
           verLH(2,:) verLH(3,:);
           verLH(3,:) verLH(4,:);
           verLH(4,:) verLL(5,:);
           verLL(5,:) verLL(6,:);
           verLL(6,:) verLL(7,:);
           verLL(7,:) verLL(8,:);
           
           verLL(8,:) TrueWalls(9,1)+d TrueWalls(9,2)-d;
           TrueWalls(9,1)+d TrueWalls(9,2)-d TrueWalls(9,3)-d TrueWalls(9,4)-d;
           TrueWalls(9,3)-d TrueWalls(9,4)-d verRL(5,:);
           
           verRL(5,:) verRL(6,:);
           verRL(6,:) verRL(7,:);
           verRL(7,:) verRL(8,:);
           verRL(8,:) verRH(1,:);
           verRH(1,:) verRH(2,:);
           verRH(2,:) verRH(3,:);
           verRH(3,:) verRH(4,:);
           
           verRH(4,:) TrueWalls(9,3)-d TrueWalls(9,4)+d;
           TrueWalls(9,3)-d TrueWalls(9,4)+d TrueWalls(9,1)+d TrueWalls(9,2)+d;
           TrueWalls(9,1)+d TrueWalls(9,2)+d verLH(1,:);
           
           ];


%% Obstacles
for i = 1:size(TrueObstacleCenters,1)
    OctagonLines = GetOctagonLines(TrueObstacleCenters(i,1), TrueObstacleCenters(i,2), d + 90);
    TrueKeepOut = [TrueKeepOut;
                    OctagonLines];
end
     

end

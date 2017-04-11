function UpdateGrafic_FigMap(i)
global TrueRobot Robot BarvnaLestvicaRGB
global qqqTrue qqqPF xxxPF hFigMap

persistent cnt
if (isempty(cnt))
    cnt = 0;
end

DrawRobot(TrueRobot.q, hFigMap.robotTrue);        % drugi parameter: robot=1, odometrija=2

if (~isempty(Robot))
    DrawRobot([Robot.PF.x Robot.PF.y Robot.PF.fi]',hFigMap.robotPF);            % drugi parameter: robot=1, odometrija=2

%     for i = 1:96
%         set(hFigMap.probSF(i),'MarkerSize', 5*Robot.Nodes(i).mtcColor + 1);
%     end
    
    [x,y,u,v] = getQuiverOptimalPath();
    set(hFigMap.pathOpt ,'XData',x,'YData',y,'UData',u,'VData',v);
    set(hFigMap.pathGoal,'XData',Robot.PP.xRef,'YData',Robot.PP.yRef);
    
    set(hFigMap.pathTrue,'XData',qqqTrue(1,1:i),'YData',qqqTrue(2,1:i));
    set(hFigMap.pathPF  ,'XData',  qqqPF(1,1:i),'YData',  qqqPF(2,1:i));
    
%     set(hFigMap.SenLCol ,'Color',BarvnaLestvicaRGB(Robot.SenRGB.Left.idx,:)/255);
%     set(hFigMap.SenRCol ,'Color',BarvnaLestvicaRGB(Robot.SenRGB.Right.idx,:)/255);
%     set(hFigMap.SenLPos ,'XData',Robot.SenRGB.Left.x,'YData',Robot.SenRGB.Left.y);
%     set(hFigMap.SenRPos ,'XData',Robot.SenRGB.Right.x,'YData',Robot.SenRGB.Right.y);
    
%     set(hFigMap.xxxPF   ,'XData',xxxPF(1,:),'YData',xxxPF(2,:));
    

%     if (~isempty(qqq))
%         idx = Robot.SF.bestMtcIdx;
%         if (idx > 0)
%             set(hhB,'XData',qqq(1,end),'YData',qqq(2,end),'MarkerSize', 10*Robot.Nodes(idx).mtcColor + 1);
%         end
%     end
    
end

end
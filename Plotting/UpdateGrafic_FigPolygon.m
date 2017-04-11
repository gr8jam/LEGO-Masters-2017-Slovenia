function UpdateGrafic_FigPolygon()
global TrueRobot Robot BarvnaLestvicaRGB
global qqqTrue qqqPF xPF qqq hFigMap hhN hhB

persistent cnt
if (isempty(cnt))
    cnt = 0;
end

DrawRobot(TrueRobot.q,1);        % drugi parameter: robot=1, odometrija=2

if (~isempty(Robot))
    DrawRobot([Robot.PF.x Robot.PF.y Robot.PF.fi]',2);            % drugi parameter: robot=1, odometrija=2

    set(hFigMap(3),'XData',qqqTrue(1,:),'YData',qqqTrue(2,:));      % izris prave poti
    set(hFigMap(4),'XData',qqqPF(1,:),'YData',qqqPF(2,:));          % izris ocenjene poti PF
%     set(hFigMap(5),'XData',xPF(1,:),'YData',xPF(2,:));                % izris delcev
    set(hFigMap(8),'Color',  BarvnaLestvicaRGB(Robot.SenRGB.Left.idx,:)/255);
    set(hFigMap(9),'Color',  BarvnaLestvicaRGB(Robot.SenRGB.Right.idx,:)/255);
    set(hFigMap(10),'XData',Robot.SenRGB.Left.x,'YData',Robot.SenRGB.Left.y);   % izris pozicije LEVEGA rgb senzorja
    set(hFigMap(11),'XData',Robot.SenRGB.Right.x,'YData',Robot.SenRGB.Right.y);   % izris pozicije DESNEGA rgb senzorja
    
    
    [x,y,u,v] = getQuiverOptimalPath();
    set(hFigMap(12),'XData',x,'YData',y,'UData',u,'VData',v);   % naèrtovane poti
    set(hFigMap(13),'XData',Robot.PP.xRef,'YData',Robot.PP.yRef);   % naèrtovane poti
    
    for i = 1:96
        set(hhN(i),'MarkerSize', 5*Robot.Nodes(i).mtcColor + 1);
    end

    if (~isempty(qqq))
        idx = Robot.SF.bestMtcIdx;
        if (idx > 0)
            set(hhB,'XData',qqq(1,end),'YData',qqq(2,end),'MarkerSize', 10*Robot.Nodes(idx).mtcColor + 1);
        end
    end
    
end

end
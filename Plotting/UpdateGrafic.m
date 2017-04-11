function UpdateGrafic()
global TrueRobot Robot 

persistent cnt
if (isempty(cnt))
    cnt = 0;
end

cnt = cnt + 1;
if (mod(cnt,3) == 0)
    cnt = 0;
    UpdateGrafic_FigPolygon();   
    UpdateGrafic_FigRGB();
    drawnow;
end

end

function UpdateGrafic(i)

persistent cnt
if (isempty(cnt))
    cnt = 0;
end

cnt = cnt + 1;
if (mod(cnt,7) == 0)
    cnt = 0;
    UpdateGrafic_FigMap(i);   
    UpdateGrafic_FigRGB();
    drawnow;
end

end

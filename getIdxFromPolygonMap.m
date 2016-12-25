function idx = getIdxFromPolygonMap(q)
global PolygonMapColors

try
    x = uint32(q(1));
    y = uint32(q(2));
    idx = PolygonMapColors(y,x);
catch
    idx = 99;
end


end
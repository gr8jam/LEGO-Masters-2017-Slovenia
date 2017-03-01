function [vertices] = GetOctagonVertices(x,y,v)

vertices = zeros(8,2);

d = v/cos(22.5*pi/180);

for i=1:8
    vertices(i,1) = x + d*cos(ToRad(45*i - 22.5));
    vertices(i,2) = y + d*sin(ToRad(45*i - 22.5));
end

vertices = round(vertices);

end


function rad = ToRad(deg)
rad = deg * pi /180;
end

function OctagonLines = GetOctagonLines(x,y,v)
ver = GetOctagonVertices(x, y, v);
OctagonLines = [
           ver(1,:) ver(2,:);
           ver(2,:) ver(3,:);
           ver(3,:) ver(4,:);
           ver(4,:) ver(5,:);
           ver(5,:) ver(6,:);
           ver(6,:) ver(7,:);
           ver(7,:) ver(8,:);
           ver(8,:) ver(1,:)];
end
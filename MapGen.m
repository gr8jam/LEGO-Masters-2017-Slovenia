fileID = fopen('Mapa.txt','w','n','UTF-8');
fprintf(fileID,'{');

for i = 1:1800
 fprintf(fileID,'{');
 fprintf(fileID,'%d,',PolygonMapColors(i,1:end-1));%PolygonMapColors(1,1)
 fprintf(fileID,'%d',PolygonMapColors(i,end));
 fprintf(fileID,'},\n');
end

fprintf(fileID,'};');
fclose(fileID);


%%
fileID = fopen('Mapa1vr.txt','w','n','UTF-8');

fprintf(fileID,'{');
fprintf(fileID,'%d,',PolygonMapColors(1,1:end-1));%PolygonMapColors(1,1)
fprintf(fileID,'%d',PolygonMapColors(1,end));
fprintf(fileID,'};');

fclose(fileID);

%%
fileID = fopen('Mapa200.txt','w','n','UTF-8');
fprintf(fileID,'{');

for i = 1:199
 fprintf(fileID,'{');
 fprintf(fileID,'%d,',PolygonMapColors(i,1:end-1));%PolygonMapColors(1,1)
 fprintf(fileID,'%d',PolygonMapColors(i,end));
 fprintf(fileID,'},\n');
end
i = 200;
 fprintf(fileID,'{');
 fprintf(fileID,'%d,',PolygonMapColors(i,1:end-1));%PolygonMapColors(1,1)
 fprintf(fileID,'%d',PolygonMapColors(i,end));
 fprintf(fileID,'}\n');

fprintf(fileID,'};');
fclose(fileID);


%%
max = 10;
file = '
fileID = fopen('Mapa10.h','w','n','UTF-8');
fprintf(fileID,'char PolygonMapColors[%d][2500] =',max);
fprintf(fileID,'{\n');

for i = 1:max-1
 fprintf(fileID,'{');
 fprintf(fileID,'%d,',PolygonMapColors(i,1:end-1));%PolygonMapColors(1,1)
 fprintf(fileID,'%d',PolygonMapColors(i,end));
 fprintf(fileID,'},\n');
end
i = max;
 fprintf(fileID,'{');
 fprintf(fileID,'%d,',PolygonMapColors(i,1:end-1));%PolygonMapColors(1,1)
 fprintf(fileID,'%d',PolygonMapColors(i,end));
 fprintf(fileID,'}\n');

fprintf(fileID,'};');
fclose(fileID);

%% 
max = 1800;
fileID = fopen('Mapa1800.rtf','w','n','UTF-8');

for i = 1:max-1
 fprintf(fileID,'%d',PolygonMapColors(i,1:end-1));%PolygonMapColors(1,1)
 fprintf(fileID,'%d',PolygonMapColors(i,end));
 %%fprintf(fileID,'\n');
end
i = max;
 fprintf(fileID,'%d',PolygonMapColors(i,1:end-1));%PolygonMapColors(1,1)
 fprintf(fileID,'%d',PolygonMapColors(i,end));
 %%fprintf(fileID,'\n');

fclose(fileID);
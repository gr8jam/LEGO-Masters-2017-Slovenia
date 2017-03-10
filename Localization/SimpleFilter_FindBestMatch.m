function SimpleFilter_FindBestMatch()

global Nodes SF

bestMtcCnt = 0;
bestMtcIdx = 0;

sameMtcCnt = 0;

for i = 1:96
    tempMtcCnt = Nodes(i).mtcColor;
    
    
    if (tempMtcCnt > bestMtcCnt)
        bestMtcCnt = tempMtcCnt;
        bestMtcIdx = i;
        sameMtcCnt = 1;
    elseif (tempMtcCnt == bestMtcCnt)
        sameMtcCnt = sameMtcCnt +1;
    end
    
end



if (sameMtcCnt > 1)
    SF.bestMtcIdx = 0;
else
    SF.bestMtcIdx = bestMtcIdx;
    
end



end


function task_Localization2()

global SF SenRGB 


if SenRGB.Right.Changed
    if (SenRGB.Right.idx == 1) || (SenRGB.Right.idx == 2)
%         error('Do not save black or whit colors')
        return;
    end
    
    SF.StackLastColors = Stack_PushElement(SF.StackLastColors, SenRGB.Right.idx);

    
    FindMatchingColors();
    
    FindBestMatch();
    
        
end







end

function FindBestMatch()

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


function FindMatchingColors()

global Nodes SF

for i = 1:96
    
    cntMatch = 0;
    for j = 1:SF.StackLastColors.inStock
        idxNode = i - j +1;
        
        switch ceil(i/32)
            case 1
                if (idxNode < 1)
                    idxNode = 32 + idxNode;
                end
            case 2
                if (idxNode < 33)
                    idxNode = 32 + idxNode;
                end
                
            case 3
                if (idxNode < 65)
                    idxNode = 32 + idxNode;
                end
                
            otherwise
                error('Wrong track \n');
        end
        
        
        try 
        
            if (Nodes(idxNode).idxColor == Stack_ReadElement(SF.StackLastColors, j))
                cntMatch = cntMatch + 1;
            else
                break;
            end
            
        catch
            waitforbuttonpress;
        end
    end
    
    Nodes(i).mtcColor = cntMatch;
    
end

end

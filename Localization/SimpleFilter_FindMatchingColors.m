function SimpleFilter_FindMatchingColors()

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
function SimpleFilter()

global SF SenRGB 

if SenRGB.Right.Changed
    if (SenRGB.Right.idx == 1) || (SenRGB.Right.idx == 2)
%         error('Do not save black or whit colors')
        return;
    end
    
    SF.StackLastColors = Stack_PushElement(SF.StackLastColors, SenRGB.Right.idx);

    
    SimpleFilter_FindMatchingColors();
    
    SimpleFilter_FindBestMatch();
    
    
        
end

end




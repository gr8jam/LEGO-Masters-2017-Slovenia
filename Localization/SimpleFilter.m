function SimpleFilter()

global SF SenRGB 

if SenRGB.Right.ChangedFil
    if (SenRGB.Right.idxFil == 1) || (SenRGB.Right.idxFil == 2)
%         error('Do not save black or whit colors')
%         return;
    end
    
    SF.PipeLastColorsR = Pipe_PushElement(SF.PipeLastColorsR, SenRGB.Right.idxFil);

    
    SimpleFilter_FindMatchingColors();
    
    SimpleFilter_FindBestMatch();
    
    
        
end

if SenRGB.Left.ChangedFil
    if (SenRGB.Left.idxFil == 1) || (SenRGB.Left.idxFil == 2)
%         error('Do not save black or whit colors')
%         return;
    end
    
    SF.PipeLastColorsL = Pipe_PushElement(SF.PipeLastColorsL, SenRGB.Left.idxFil);

    

end




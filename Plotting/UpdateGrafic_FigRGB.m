function UpdateGrafic_FigRGB()
global Robot BarvnaLestvicaRGB 
global hFigRGB

    for i = -3:1:3
        for j = -3:1:3
            idx = Robot.SenRGB.Left.ColorArray(4-j,4-i);
            if (idx > 0)
                set(hFigRGB.arrayL(4-j,4-i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
            else
                set(hFigRGB.arrayL(4-j,4-i),'FaceColor','m');
            end
        end
    end
    
    for i = 1:7
        for j = 1:7
            idx = Robot.SenRGB.Right.ColorArray(j,i);
            if (idx > 0)
                set(hFigRGB.arrayR(j,i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
            else
                set(hFigRGB.arrayR(j,i),'FaceColor','m');
            end
        end
    end
    
    for i = 1:length(hFigRGB.PipeR)
        idx = Robot.SF.PipeLastColorsR.buffer(i);
        if (idx > 0)
            set(hFigRGB.PipeR(i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
        else
            set(hFigRGB.PipeR(i),'FaceColor','m');
        end
    end

    for i = 1:length(hFigRGB.PipeL)
        idx = Robot.SF.PipeLastColorsL.buffer(i);
        if (idx > 0)
            set(hFigRGB.PipeL(i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
        else
            set(hFigRGB.PipeL(i),'FaceColor','m');
        end
    end
end


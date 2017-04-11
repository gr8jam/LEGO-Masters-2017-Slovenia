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
    
    for i = 1:length(hFigRGB.StackR)
        idx = Robot.SF.StackLastColorsR.buffer(i);
        if (idx > 0)
            set(hFigRGB.StackR(i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
        else
            set(hFigRGB.StackR(i),'FaceColor','m');
        end
    end

    for i = 1:length(hFigRGB.StackL)
        idx = Robot.SF.StackLastColorsL.buffer(i);
        if (idx > 0)
            set(hFigRGB.StackL(i),'FaceColor',BarvnaLestvicaRGB(idx,:)/255);
        else
            set(hFigRGB.StackL(i),'FaceColor','m');
        end
    end
end


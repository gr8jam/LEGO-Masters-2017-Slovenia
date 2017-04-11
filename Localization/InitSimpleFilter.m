function SF = InitSimpleFilter()


PipeLastColors = InitPipe(5);

StackLastColorsR = InitStack(5);
StackLastColorsL = InitStack(5);

                    
bestMtcIdx = 0;

SF = struct('PipeLastColors', PipeLastColors,...
            'StackLastColorsR', StackLastColorsR,...
            'StackLastColorsL', StackLastColorsL,...
            'bestMtcIdx',bestMtcIdx);


end

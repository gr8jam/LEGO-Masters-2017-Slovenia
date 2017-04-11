function SF = InitSimpleFilter()


% PipeLastColors = InitPipe(5);

PipeLastColorsR = InitPipe(5);
PipeLastColorsL = InitPipe(5);

                    
bestMtcIdx = 0;

SF = struct('PipeLastColorsR', PipeLastColorsR,...
            'PipeLastColorsL', PipeLastColorsL,...
            'bestMtcIdx',bestMtcIdx);


end

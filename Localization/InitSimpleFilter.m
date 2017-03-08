function SF = InitSimpleFilter()


PipeLastColors = InitPipe(5);

StackLastColors = InitStack(5);
                    
bestMtcIdx = 0;

SF = struct('PipeLastColors', PipeLastColors,...
            'StackLastColors', StackLastColors,...
            'bestMtcIdx',bestMtcIdx);


end

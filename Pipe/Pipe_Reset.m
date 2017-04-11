function PipeOut = Pipe_Reset(Pipe)

Pipe.inStock = 0;
Pipe.buffer = zeros(Pipe.size,1);


PipeOut = Pipe;


end

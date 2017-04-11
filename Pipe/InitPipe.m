function Pipe = InitPipe(PipeSize)


inStock = 0;
size = PipeSize;
buffer = zeros(size,1);

Pipe = struct('inStock',inStock,...
               'size', size,...
               'buffer',buffer);

end

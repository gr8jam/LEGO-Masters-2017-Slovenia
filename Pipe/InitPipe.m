function Pipe = InitPipe(bufferSize)


begin = 0;
stop = 0;
inStock = 0;
size = bufferSize + 1;
buffer = zeros(size,1);

Pipe = struct('begin',begin,...
              'stop',stop,...
              'inStock',inStock,...
              'size',size,...
              'buffer',buffer);


end

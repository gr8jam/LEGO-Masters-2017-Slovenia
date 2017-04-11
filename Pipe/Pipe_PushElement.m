function PipeOut = Pipe_PushElement(Pipe, element)


for i = Pipe.inStock:-1:1
    Pipe.buffer(i+1) = Pipe.buffer(i);
%     for (i = Stock.inStock; i>0; i--)         # C language
%       Pipe.buffer(i) = Pipe.buffer(i-1);    # C language
end

Pipe.buffer(1) = element;
Pipe.inStock = Pipe.inStock + 1;
if (Pipe.inStock > Pipe.size)
    Pipe.inStock = Pipe.size;
end

% Stock.buffer(0) = element;          # C language
% Pipe.inStock = Pipe.inStock + 1;    # C language
% if (Pipe.inStock > Pipe.size)       # C language
%     Pipe.inStock = Pipe.size;       # C language
% end


PipeOut = Pipe;

end
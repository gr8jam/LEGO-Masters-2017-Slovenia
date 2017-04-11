function element = Pipe_ReadElement(Pipe, elementNum)

if (elementNum <= Pipe.inStock)
    element = Pipe.buffer(elementNum);
%     element = Pipe.buffer(elementNum-1);  %% C language
else
    error('Accesing element that is not stored! \n');
end



end

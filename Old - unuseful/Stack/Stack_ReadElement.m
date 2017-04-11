function element = Stack_ReadElement(Stack, elementNum)

if (elementNum <= Stack.inStock)
    element = Stack.buffer(elementNum);
%     element = Stack.buffer(elementNum-1);  %% C language
else
    error('Accesing element that is not stored! \n');
end



end

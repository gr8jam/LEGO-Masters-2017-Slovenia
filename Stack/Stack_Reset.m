function StackOut = Stack_Reset(Stack)

Stack.inStock = 0;
Stack.buffer = zeros(Stack.size,1);


StackOut = Stack;


end

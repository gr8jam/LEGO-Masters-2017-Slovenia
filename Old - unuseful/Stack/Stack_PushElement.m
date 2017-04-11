function StackOut = Stack_PushElement(Stack, element)


for i = Stack.inStock:-1:1
    Stack.buffer(i+1) = Stack.buffer(i);
%     for (i = Stock.inStock; i>0; i--)         # C language
%       Stack.buffer(i) = Stack.buffer(i-1);    # C language
end

Stack.buffer(1) = element;
Stack.inStock = Stack.inStock + 1;
if (Stack.inStock > Stack.size)
    Stack.inStock = Stack.size;
end

% Stock.buffer(0) = element;          # C language
% Stack.inStock = Stack.inStock + 1;    # C language
% if (Stack.inStock > Stack.size)       # C language
%     Stack.inStock = Stack.size;       # C language
% end


StackOut = Stack;

end
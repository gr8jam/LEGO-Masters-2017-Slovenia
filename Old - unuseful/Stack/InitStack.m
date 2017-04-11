function Stack = InitStack(stackSize)


inStock = 0;
size = stackSize;
buffer = zeros(size,1);

Stack = struct('inStock',inStock,...
               'size', size,...
               'buffer',buffer);

end

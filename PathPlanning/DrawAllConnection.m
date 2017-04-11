function DrawAllConnection(fig, Nodes)
figure(fig);
hold on;

for i = 1:96
% for idx = 1:PP.lenPath 
%     i = PP.Path(idx);
    xi = Nodes(i).x;
    yi = Nodes(i).y;
    for j = 1:length(Nodes(i).ConnIndex)
        idxj = Nodes(i).ConnIndex(j);
        if (idxj == 0)
            break;
        else
            xj = Nodes(idxj).x;
            yj = Nodes(idxj).y;

            [xarrow, yarrow] = ComputeArrowHead(xi,yi,xj,yj,pi/6,45);
%             hj(j) = plot([xi xj],[yi yj],'b-','LineWidth',2,'erasemode','xor');    
%             set(hj(j),'XData',[xi xj xarrow],'YData',[yi yj yarrow]);
            plot([xi xj xarrow],[yi yj yarrow], 'k-','LineWidth',2);
        end
    end
end
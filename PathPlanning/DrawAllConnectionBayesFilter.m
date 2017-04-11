function DrawAllConnectionBayesFilter(fig, Nodes)
figure(fig);
hold on;

for i = 1:96
% for idx = 1:PP.lenPath 
%     i = PP.Path(idx);
    xi = Nodes(i).x;
    yi = Nodes(i).y;
    
    
    for j = 1:Nodes(i).BFconnCntF
        idxj = Nodes(i).BFconnIdxF(j);
        if (idxj == 0)
            break;
        else
            xj = Nodes(idxj).x;
            yj = Nodes(idxj).y;

            [xarrow, yarrow] = ComputeArrowHead(xi,yi,xj,yj,pi/6,35);
            plot([xi xj xarrow],[yi yj yarrow],'k-','LineWidth',1);
        end
    end
    
    for j = 1:Nodes(i).BFconnCntL
        idxj = Nodes(i).BFconnIdxL(j);
        if (idxj == 0)
            break;
        else
            xj = Nodes(idxj).x;
            yj = Nodes(idxj).y;

            [xarrow, yarrow] = ComputeArrowHead(xi,yi,xj,yj,pi/6,35);
            plot([xi xj xarrow],[yi yj yarrow],'k-','LineWidth',1);
        end
    end
    
    for j = 1:Nodes(i).BFconnCntR
        idxj = Nodes(i).BFconnIdxR(j);
        if (idxj == 0)
            break;
        else
            xj = Nodes(idxj).x;
            yj = Nodes(idxj).y;

            [xarrow, yarrow] = ComputeArrowHead(xi,yi,xj,yj,pi/6,35);
            plot([xi xj xarrow],[yi yj yarrow],'k-','LineWidth',1);
        end
    end
end



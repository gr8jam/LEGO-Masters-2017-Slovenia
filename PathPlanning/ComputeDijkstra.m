function ComputeDijkstra(StartIdx)
draw_flag = false;
global Nodes OpenListIndex OpenListWeights CloseListIndex

OpenListIndex = [StartIdx];
OpenListWeights = [0];
CloseListIndex = [];

%% Set cost of all nodes to something high
for i = 1:length(Nodes)
    Nodes(i).cost = 99999999;
end
Nodes(StartIdx).cost = 0;

%% Add handels for current node and node connections
if draw_flag
    hi = plot(0,0,'g.','MarkerSize',35,'erasemode','xor'); % current node
    hj = plot(0,0,'go','MarkerSize',10,'LineWidth',7,'erasemode','xor');   % current node area
    for j = 1:10
        hc(j) = plot(0,0,'b-','LineWidth',2,'erasemode','xor'); % current node connections
    end
end

while(~isempty(OpenListIndex))
%     %% Take first element out form OpenList
%     IdxCurr = popOpenList();

    %% Take element with smallest cost out form OpenList
    IdxCurr = popOpenList();
    
    if draw_flag
        xi = Nodes(IdxCurr).x;
        yi = Nodes(IdxCurr).y;
        set(hi,'XData',xi,'YData',yi);
    end
    %% Compute new cost and connections
    j = 1;
    while (Nodes(IdxCurr).ConnIndex(j) ~= 0)
        IdxConn = Nodes(IdxCurr).ConnIndex(j);
        
        if draw_flag
            xj = Nodes(IdxConn).x;
            yj = Nodes(IdxConn).y;
            set(hj,'XData',xj,'YData',yj);
        end
        if (~checkCloseList(IdxConn))
            new_cost = Nodes(IdxCurr).cost + Nodes(IdxCurr).ConnWeight(j);
            old_cost = Nodes(IdxConn).cost;
            if (Nodes(IdxConn).cost > new_cost)
                Nodes(IdxConn).cost = new_cost;
                Nodes(IdxConn).path = IdxCurr;
            end
            pushOpenList(IdxConn, Nodes(IdxConn).cost);
            
        end
        j = j + 1;
    end

    %% Push Current node to ClosedList
    pushCloseList(IdxCurr);

    %% Sort OpenList by weights
    
end
end


function CurrNode = popOpenList()
global OpenListIndex OpenListWeights

idx = 1;
for i = 1:length(OpenListIndex)
    if (OpenListWeights(idx) > OpenListIndex(i))
        idx = 1;
    end
end

CurrNode = OpenListIndex(idx);
OpenListIndex(idx) = OpenListIndex(1);
% CurrNode = OpenListIndex(1);
OpenListIndex = OpenListIndex(2:end);

OpenListWeights(idx) = OpenListWeights(1);
OpenListWeights = OpenListWeights(2:end);
end

function pushOpenList(index, weight)
global OpenListIndex OpenListWeights

for i = 1:length(OpenListIndex)
    if (index == OpenListIndex(i))
        return;
    end
end
OpenListIndex = [OpenListIndex index];
OpenListWeights = [OpenListWeights weight];
end

function pushCloseList(index)
global CloseListIndex
CloseListIndex = [CloseListIndex index];
end

function bool = checkCloseList(index)
global CloseListIndex
bool = false;
for i = 1:length(CloseListIndex)
    if (index == CloseListIndex(i))
        bool = true;
        return
    end
end
end


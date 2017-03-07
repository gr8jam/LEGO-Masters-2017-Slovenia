function q_path = GetOptimalpath()

global Nodes

idx = [20 25 30 35 40 45 50 52 55 90 93 65 68 75];
q_path = []; 

for i = 1:length(idx)
    x = Nodes(idx(i)).x;
    y = Nodes(idx(i)).y;
    fi = Nodes(idx(i)).fi;
    q_ref = [x y fi idx(i)]';
    q_path = [q_path q_ref];
    
end

end
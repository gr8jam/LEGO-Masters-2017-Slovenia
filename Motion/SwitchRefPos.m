function q_ref_out = SwitchRefPos(q_sen)

global Nodes Path

persistent idx
if isempty(idx)
    idx = 1;
end

persistent q_ref
if isempty(q_ref)
    x = Nodes(Path(idx)).x;
    y = Nodes(Path(idx)).y;
    fi = Nodes(Path(idx)).fi;
    q_ref = [x y fi]';
end

d_min = 35;

if (abs(q_ref(1) - q_sen(1)) < d_min) && (abs(q_ref(2) - q_sen(2)) < d_min)
    idx = idx + 1;
    x = Nodes(Path(idx)).x;
    y = Nodes(Path(idx)).y;
    fi = Nodes(Path(idx)).fi;
    q_ref = [x y fi]';
    
    DEBUG = true;
    if (DEBUG) fprintf('path_idx = %d\n', Path(idx)); end;
    
end


q_ref_out = q_ref;

end
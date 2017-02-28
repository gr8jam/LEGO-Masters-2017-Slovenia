function q_ref_out = SwitchRefPos(q_sen, q_path)

persistent idx
if isempty(idx)
    idx = 1;
end

persistent q_ref
if isempty(q_ref)
    q_ref = q_path(1:3,idx);
end

d_min = 10;

if (abs(q_ref(1) - q_sen(1)) < 10) && (abs(q_ref(2) - q_sen(2)) < 10)
    idx = idx + 1;
    q_ref = q_path(1:3,idx);
    DEBUG = true;
    if (DEBUG) fprintf('path_idx = %d\n', q_path(4,idx)); end;
    
end


q_ref_out = q_ref;

end
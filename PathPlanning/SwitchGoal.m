function SwitchGoal()

global PP PF Nodes

% persistent idx
% if isempty(idx)
%     idx = 1;
% end

% persistent q_ref
% if isempty(q_ref)
%     x = Nodes(PP.Path(cntPath)).x;
%     y = Nodes(PP.Path(cntPath)).y;
%     
% end

%ClosestNodeIdx = GetClosestNode();
    
d_min = 45;

% if (abs(PP.xRef - PF.x) < d_min) && (abs(PP.yRef - PF.y) < d_min)
if ((PP.xRef - PF.x)^2 + (PP.yRef - PF.y)^2 < d_min^2)
    PP.cntPath = PP.cntPath + 1;
    
    
    PP.Goal = PP.Path(PP.lenPath - PP.cntPath);
    PP.xRef = Nodes(PP.Goal).x;
    PP.yRef = Nodes(PP.Goal).y;
    
    DEBUG = false;
    if (DEBUG) fprintf('path_idx = %d\n', PP.Path(PP.cntPath)); end;
    
end




end


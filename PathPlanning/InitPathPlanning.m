function PP = InitPathPlanning()


Path = zeros(1,100);
Goal = 0;

PP = struct('State', 'New',...
            'Path', Path,...    % array of indexs
            'cntPath', 0,...    % counter of successfully completed node on the path
            'lenPath', 0,...    % length of nodes in a path
            'Goal', Goal,...    % index of goal node
            'xRef', 0,...       % x coordinate of reference position
            'yRef', 0,...       % y coordinate of reference position            
            'Flag_RecalculatePath', false,...
            'Flag_PathFound', false);      




end

function BayesFilter_Aposteriori()
global BF Nodes SenRGB

    % Normalization constant
    p_Zk = 0;
    
    for idx = 1:length(Nodes)
        if (Nodes(idx).idxColor == SenRGB.Right.idxFil)
            p_Zk_Xk = 0.85;
        else
            p_Zk_Xk = 0.15;
        end

        BF.Apost(idx) = p_Zk_Xk * BF.Aprio(idx);
        
        p_Zk = p_Zk + p_Zk_Xk * BF.Aprio(idx);

    end
    
    for idx = 1:length(Nodes)  
        BF.Apost(idx) = BF.Apost(idx)/p_Zk;
    end
    
    
    
%     
%     %% korection
%     for idx = 1:length(Nodes)
%         BF.Apost(idx) = BF.Aprio(idx);
%     end

end


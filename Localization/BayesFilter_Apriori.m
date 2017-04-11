function BayesFilter_Apriori()
global BF Nodes SenRGB


%% reset apriori
for idx = 1:length(Nodes)
    BF.Aprio(idx) = 0;
end

for i = 1:length(Nodes)

%         try
        if (BF.Flag_Forward)
            factorF = 0.80;
            if (Nodes(i).BFconnCntF ~= 0)
                factorF = factorF / Nodes(i).BFconnCntF;
            end
            factorL = (1 - factorF * Nodes(i).BFconnCntF) / (Nodes(i).BFconnCntL + Nodes(i).BFconnCntR);
            factorR = factorL;

            factorF = factorF / Nodes(i).BFconnCntF;

        elseif (BF.Flag_TurnLeft)
            factorL = 0.75;
            if (Nodes(i).BFconnCntL ~= 0)
                factorL = factorL / Nodes(i).BFconnCntL;
            end
            factorF = (1 - factorL * Nodes(i).BFconnCntL) / (Nodes(i).BFconnCntF + Nodes(i).BFconnCntR);
            factorR = factorF;

        elseif (BF.Flag_TurnRight)
            factorR = 0.75;
            if (Nodes(i).BFconnCntR ~= 0)                    
                factorR = factorR / Nodes(i).BFconnCntR;
            end
            factorF = (1 - factorR * Nodes(i).BFconnCntR) / (Nodes(i).BFconnCntF + Nodes(i).BFconnCntL);
            factorL = factorF;

        else 
            factorF = 1;
            factorL = 0;
            factorR = 0;
        end

        for j = 1:Nodes(i).BFconnCntF
            idx = Nodes(i).BFconnIdxF(j);
            BF.Aprio(idx) = BF.Aprio(idx) + BF.Apost(i) * factorF;
        end

        for j = 1:Nodes(i).BFconnCntL
            idx = Nodes(i).BFconnIdxL(j);
            BF.Aprio(idx) = BF.Aprio(idx) + BF.Apost(i) * factorL;
        end

        for j = 1:Nodes(i).BFconnCntR
            idx = Nodes(i).BFconnIdxR(j);
            BF.Aprio(idx) = BF.Aprio(idx) + BF.Apost(i) * factorR;
        end
%         catch
%             a = 0;
%         end
%     fprintf('Apriori sum: %3.5f \n',sum(BF.Aprio));

end
end




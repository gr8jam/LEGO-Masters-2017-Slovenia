function BayesFilter_FindBestMatch()
global BF


bestMtcVal = 0;
bestMtcIdx = 0;


for idx = 1:96
    if (bestMtcVal < BF.Apost(idx))
        bestMtcVal = BF.Apost(idx);
        bestMtcIdx = idx;
    end
end


BF.bestMtcIdx = bestMtcIdx;
BF.bestMtcVal = bestMtcVal;



end

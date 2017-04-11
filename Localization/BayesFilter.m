function BayesFilter()
global BF SenRGB

if (BF.Flag_NewMotion)
    BayesFilter_Apriori();
    BF.Flag_NewMotion = false;
end

if (SenRGB.Right.ChangedFil)
    BayesFilter_Aposteriori();
end


BayesFilter_FindBestMatch();

end



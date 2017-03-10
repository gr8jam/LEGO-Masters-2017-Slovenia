function task_Localization2()


SimpleFilter();

% BayesFilter();



end



function BayesFilter()

global Nodes

global BF SenRGB 

if SenRGB.Right.Changed
    
    
        
end




end



% % function CalculateAposteriori()
% % 
% % 
% % %% Aposteriori
% % if (SenRGB.Right.idx == 1) || (SenRGB.Right.idx == 2)
% % %         error('Do not save black or whit colors')
% %     return;
% % end
% % 
% % 
% % SF.StackLastColors = Stack_PushElement(SF.StackLastColors, SenRGB.Right.idx);
% % 
% % 
% % SimpleFilter_FindMatchingColors();
% % 
% % SimpleFilter_FindBestMatch();
% % 
% % %% Apriori
% %     
% %     
% % end



function task_Localization2()


SimpleFilter();

BayesFilter();



end



function DrivingBehaviour()

persistent state
if isempty(state)
    state = 'forward'
end

state = 'forward';
state = 'goingLeft';
state = 'goingRight';


% switch state
%     case 'forward'
%         if SenRGB.Right.Changed
% 
% 
% end
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



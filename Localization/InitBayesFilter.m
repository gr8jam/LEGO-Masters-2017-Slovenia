function BF = InitBayesFilter()

Aprio = ones(96,1) * 1/96;
Apost = ones(96,1) * 1/96;

BF = struct('Aprio', Aprio,...
            'Apost', Apost,...
            'Flag_TurnLeft', false,...
            'Flag_TurnRight', false,...
            'Flag_Straight', false);




end

function SenRGB = InitSenRGB()
%% RGB color sensor on the LEFT
Left.Red = 0;
Left.Green = 0;
Left.Blue = 0;

Left.Hue = 0;
Left.Satration = 0;
Left.Value = 0;

Left.idx = 1;

Left.dx = 50;
Left.dy = 30;

Left.x = 0;
Left.y = 0;

%% RGB color sensor on the RIGHT
Right.Red = 0;
Right.Green = 0;
Right.Blue = 0;

Right.Hue = 0;
Right.Satration = 0;
Right.Value = 0;

Right.idx = 1;

Right.dx = 50;
Right.dy = -30;

Right.x = 0;
Right.y = 0;

%% Output
SenRGB.Left = Left;
SenRGB.Right = Right;


end

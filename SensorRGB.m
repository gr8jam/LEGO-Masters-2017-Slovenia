function [ barva, P1, P2 ] = SensorRGB( q , mapa)

 barva = zeros(4,1);                                                        % vektor za prebrano barvo

 P1 = [20;(16 + 20)];                                                               % pozicija prvega senzorja
 P11= [20;(18 + 20)];
 P2 = [20;-16];                                                             % pozicija drugega senzorja 
 P21= [20;-18];
 P  = [P1 P2 P11 P21];                                                      % vsi senzorji
 
 theta = q(3);                                                              % orientacija robota
 
 Rkol = [cos(theta) -sin(theta); sin(theta) cos(theta)];                    % rotacijska matrika
 
 T = repmat([q(1);q(2)],1,size(P,2)) ;

 P = Rkol * P + T;                                                          % toèke transliramo in rotiramo

 barva(1) = mapa(uint64(P(2,1)), uint64(P(1,1)));                           % barva prvega senzorja
 barva(2) = mapa(uint64(P(2,2)), uint64(P(1,2)));                           % barva drugega senzorja
 barva(3) = mapa(uint64(P(2,3)), uint64(P(1,3)));                           % barva prvega+ senzorja
 barva(4) = mapa(uint64(P(2,4)), uint64(P(1,4)));                           % barva drugega+ senzorja

 P1 = [P(1,1) P(2,1)];
 P2 = [P(1,2) P(2,2)];
end


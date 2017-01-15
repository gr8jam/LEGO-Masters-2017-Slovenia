function dist = SimulationDist( q )
global Obstacles

R = 10;
kot = 0;
  % parametri:
  % kot = kot pod katerim merimo razdaljo do ovire
  % q = lega robota
  % R = varianca šuma meritve razdalje
  % minRazdalja = razdalja od robota do ovire v smeri kota
  
  MAX_DOSEG_SENZORJA=2000;
  
    % premici
    % A1,B1,C1;           // premica, ki jo doloca robot in smer tipanja robota
    % A2,B2,C2;           // premica, ki jo dolocata tocki daljice okolja
    
    xr=q(1); yr=q(2); fir=q(3);
    KotTipanja=kot+fir;
 
    A1=sin(KotTipanja);  % enaèba premice žarka A1x+B1y+C1=0
    B1=-cos(KotTipanja);
    C1=-xr*A1-yr*B1;
    
    Det=0;
    minRazdalja=100000;
 
     % tu testiraj premice in vrni kot
     for i=1:size(Obstacles,1)
        x1=Obstacles(i,1); y1=Obstacles(i,2); x2=Obstacles(i,3);  y2=Obstacles(i,4);

        A2=  y2-y1;   % enaèba premice daljice okola A2x+B2y+C2=0  
        B2= -x2+x1;
        C2= -x1*A2 - y1*B2;
      
        Det=A1*B2-A2*B1;

        if(Det ~= 0)           % premice se krizata
            % dolocimo presecisce
            xp=(B1*C2-B2*C1)/Det;
            yp=(C1*A2-C2*A1)/Det;

            razdalja = sqrt((xr-xp)^2+(yr-yp)^2);
            

            % ali je ta razdalja sploh smiselna - objekt je pred senzorjem in ne zadaj
           if( (cos(KotTipanja)*(xp-xr)+sin(KotTipanja)*(yp-yr)) >=0)
                % ali je tocka presicisca znotraj daljice
                pogoj1= (x1<= xp && xp <= x2) || (x2<= xp && xp <= x1) || abs(x1-x2)<3*eps;
                pogoj2= (y1<= yp && yp <= y2) || (y2<= yp && yp <= y1) || abs(y1-y2)<3*eps;

                if(pogoj1&&pogoj2)
                    if(razdalja<minRazdalja)
                        minRazdalja=razdalja;
                    end
                end
           end
        end
    end % for
    
     minRazdalja=minRazdalja+sqrt(R)*randn(1,1); % dodamo še šum na meritev

     % tu saturiraj razdaljo, naj nebo vec kot max doseg
     if(minRazdalja>MAX_DOSEG_SENZORJA)
        minRazdalja=MAX_DOSEG_SENZORJA;
     end
     
     dist = minRazdalja;
end


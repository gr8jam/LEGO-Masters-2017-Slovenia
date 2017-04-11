function StoreData(i)
global TrueRobot Robot Ts
global qqqTrue qqqPF qqqSF xxxPF vvv www ttt

qqqTrue(:,i) = TrueRobot.q;
if (~isempty(Robot))
    q = [Robot.PF.x Robot.PF.y Robot.PF.fi]'; % X Robot.Y Robot.Fi]';
    qqqPF(:,i) = q; % = [qqqPF q];
    
    if (~isempty(Robot.PF.xParticles))
        xxxPF = Robot.PF.xParticles;
    end
    
    vvv(i) = Robot.MC.v;
    www(i) = Robot.MC.w;
    ttt(i) = Ts*i;
    
    if (Robot.SF.bestMtcIdx ~= 0)
        idx = Robot.SF.bestMtcIdx;
        x = Robot.Nodes(idx).x;
        y = Robot.Nodes(idx).y;
        fi = Robot.Nodes(idx).fi;
        q = [x y fi]'; % X Robot.Y Robot.Fi]';
        qqqSF(:,i) = q; 
    end
    
end

end


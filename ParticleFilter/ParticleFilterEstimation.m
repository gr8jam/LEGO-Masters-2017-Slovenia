function reInit = ParticleFilterEstimation

global Robot

persistent errCnt
if isempty(errCnt)
    errCnt = 0;
end

[idxL, idxR] = SimulationRGB(Robot.q);

if (Robot.idxL == idxL) && (Robot.idxR == idxR)
    errCnt = 0;
else
    errCnt = errCnt +1;
end

if errCnt > 50000
    reInit = true;
    errCnt = 0;
else
    reInit = false;
end


end
function GetPoseFromParticleAvrage()

global PF

xMean = 0;
yMean = 0;
fiMean = 0;
for i=1:PF.nParticles
    xMean = xMean + PF.xParticles(1,i);
    yMean = yMean + PF.xParticles(2,i);
    fiMean = fiMean + PF.xParticles(3,i);
end

PF.x = xMean/PF.nParticles;
PF.y = yMean/PF.nParticles;
PF.fi = wrapToPi(fiMean/PF.nParticles);

end

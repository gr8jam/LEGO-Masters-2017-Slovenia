function iNextGeneration = resampleParticles(W,nParticles)
    %izberemo glede na ute¡zi delcev
    CDF = cumsum(W)/sum(W);
    iSelect = rand(nParticles,1); % naklju¡cno izbrana ¡stevila
    % indeksi novih delcev
    CDFg=[0;CDF];
    indg=[1;(1:nParticles)'];
    iNextGeneration_float = interp1(CDFg,indg,iSelect,'linear');
    iNextGeneration=round(iNextGeneration_float+0.5); % zaokrožimo indeks navzgor na celo število
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



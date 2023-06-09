function [spiketimes]=absoluteRefractoryNeuron(deltaAbs,rateR,timeEnd)

%  Poisson neurons with absolute refractoriness can transmit slow signals more
% reliably than a simple Poisson process.

tt=0;
jj=1;
spiketimes(jj)=cumsum(exprnd(1./rateR,1,1));
while tt<timeEnd
    tt=spiketimes(jj)+deltaAbs;
    jj=jj+1;
    spiketimes(jj)=spiketimes(jj-1)+deltaAbs+(exprnd(1./rateR,1,1));
end

end

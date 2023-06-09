function [cvISI]=coefVar(spiketimes,timewindow)

% A Poisson process produces
% distributions with CV = 1. A value of CV > 1 implies that a given spike train is less regular
% than a Poisson process with the same firing rate. If CV < 1, then the spike train is more
% regular. Most deterministic integrate-and-fire neurons fire periodically when driven by a
% constant stimulus and therefore have CV = 0. Intrinsically bursting neurons, however, can
% have CV > 1.

starttime = timewindow(1);
endtime = timewindow(2);
st=spiketimes;
for kk=1:length(st)
    spiketimes = cell2mat(st(kk));
    spiketimes = spiketimes(spiketimes>starttime & spiketimes<endtime);
    isi(kk)={diff((spiketimes))};
    meanISI(kk)=mean(cell2mat(isi(kk)));
    stdISI(kk) = std(cell2mat(isi(kk)));
end
cvISI = stdISI./meanISI;

end


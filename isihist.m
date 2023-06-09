function isihist(spiketimes,timewindow,nbins)
starttime = timewindow(1);
endtime = timewindow(2);
st=spiketimes;
for kk=1:length(st)
    spiketimes = cell2mat(st(kk));
    spiketimes = spiketimes(spiketimes>starttime & spiketimes<endtime);
    isi(kk)={diff((spiketimes))};
end

isi = cell2mat(isi);
isi(isi<0)=-isi(isi<0);
% timedur = endtime-starttime;
% timevec = starttime:(timedur./1000):endtime;
histfit(isi,nbins,'exponential');
fitdist(isi','exponential')

end

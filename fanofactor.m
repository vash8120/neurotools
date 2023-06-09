function [ff,meanSR] = fanofactor(spiketimes,timewindow)
% spiketimes(1)={[2,4,5,7,8]}
% spiketimes(2)={[4,5,7,8]}
% starttime = timewindow(1);
% endtime = timewindow(2);

starttime = timewindow(1);
endtime = timewindow(2);

st=spiketimes;

for kk=1:length(st)
    spiketimes = cell2mat(st(kk));
    spiketimes = spiketimes(spiketimes>=starttime & spiketimes<=endtime);
    T = endtime-starttime;
    spikecount(kk) = sum(spiketimes>=starttime);
    spikerate(kk) = spikecount(kk)./T;
end

meanN = mean(spikecount);
meanSR = meanN./T;
meanDN2 = mean((spikecount-meanN).^2);

ff = meanDN2./meanN;
% 
% for jj=1:100
% spiketimes(jj)={cumsum(exprnd(1,1,20))};
% end

end

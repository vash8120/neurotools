function [tdff,tdsr,timevec] = psth(spiketimes,timewindow,binsize)

s=0;
for tt=timewindow(1):binsize:timewindow(2)
    [temp,temp2]=fanofactor(spiketimes,[tt,tt+binsize]);
    s=s+1;
    tdsr(s)=temp2;
    tdff(s) = temp; 
end
timevec = timewindow(1):binsize:timewindow(2);
figure
plot(timevec,tdsr,'o-');
ylim([0,30])
title('psth')
xlabel('time bins')
ylabel('spike rate')
end

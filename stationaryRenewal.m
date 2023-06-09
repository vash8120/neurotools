function [spiketimes]=stationaryRenewal(a0,deltaAbs,timeEnd)
% Renewal processes keep a memory of the last event (last firing time) ˆt, but
% not of any earlier events. More precisely, spikes are generated in a renewal process, with a
% stochastic intensity (or “hazard”)

% since the dependence is restricted to the most recent event, intervals between
% subsequent events are independent. Therefore, an efficient way of generating a spike train
% of a renewal system is to draw interspike intervals from the distribution P0(s)
ss=0:0.0001:1000;
pdfRen = a0.*(ss-deltaAbs).*exp(-(a0./2).*((ss-deltaAbs).^2));
cdfRen = cumsum(pdfRen)./sum(pdfRen);
tt=0;
jj=1;
spiketimes(jj)=0;
while tt<timeEnd
    tt=spiketimes(jj)+deltaAbs;
    jj=jj+1;
    randomDraw = unifrnd(0,1);
    [~,indexSS] = min(abs(randomDraw-cdfRen)-0.0001);
    spiketimes(jj)=spiketimes(jj-1)+deltaAbs+ss(indexSS);
end

figure
ax(1)=subplot(3,1,1)
plot(ss,pdfRen);
title('interval distribution')

ax(2)=subplot(3,1,2)
plot(ss, a0.*(ss-deltaAbs))
title('hazard')

ax(3)=subplot(3,1,3)
plot(ss, pdfRen./(a0.*(ss-deltaAbs)))
title('survivor function')

linkaxes(ax,'x')

end





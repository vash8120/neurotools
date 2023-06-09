function [spiketimes]=stationaryRenewal2(nu,deltaAbs,lambda,timeEnd)
% Renewal processes keep a memory of the last event (last firing time) ˆt, but
% not of any earlier events. More precisely, spikes are generated in a renewal process, with a
% stochastic intensity (or “hazard”)

% since the dependence is restricted to the most recent event, intervals between
% subsequent events are independent. Therefore, an efficient way of generating a spike train
% of a renewal system is to draw interspike intervals from the distribution P0(s)


% in auditory neurons of the cat driven by stationary stimuli, the hazard func-
% tion ?0(t ? ˆt) increases, after an absolute refractory time, to a constant level 

ss=0:0.0001:1000;
pdfRen = (exp(-nu.*ss)).*(exp((nu.*(1-exp(-lambda.*ss)))./lambda)).*nu.*(1-exp(-lambda.*ss));
% a0.*(ss-deltaAbs).*exp(-(a0./2).*((ss-deltaAbs).^2));
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
plot(ss,nu.*(1-exp(-lambda.*ss)))
title('hazard')

ax(3)=subplot(3,1,3)
plot(ss, pdfRen./(nu.*(1-exp(-lambda.*ss))))
title('survivor function')

linkaxes(ax,'x')

figure
pdfRen=pdfRen(1:end-1);
PRF = fft(pdfRen);
L=length(pdfRen)
P2 = abs(PRF/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
Fs=1./0.0001;
f = Fs*(0:(L/2))/L;
PC = nu.*real((1+(PRF./L))./(1-(PRF./L)));
PC=PC(1:L/2+1);
ax(1)=subplot(2,1,1)
plot(f,P1)
title('interval distribution fft')
ax(2)=subplot(2,1,2)
plot(f,PC)
title('interval distribution fft')

linkaxes(ax,'x')

end




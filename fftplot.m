function fftplot(y,Fs)
T=1./Fs;
L=length(y);
t = (0:L - 1)*T;
YY=fft(y);
P2 = abs(YY./L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1)
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

end
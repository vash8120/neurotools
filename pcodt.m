function [dydt]=pcodt(t,y,pars)

Ptemp =  2*pi*pars.Pin(t);
for ii=1:6
    s=0;
    for jj=1:6
        s = s + (pars.K*pars.A(ii,jj).*sin(y(jj)-y(ii)-pars.thetapref(ii,jj)));
    end
    dydt(ii) = 2*pi*pars.fvec(ii) + s + 2*pi*normrnd(0,pars.noiseStd) +  Ptemp(ii);
% dydt(ii) = 2*pi*pars.fvec(ii) + s + 2*pi*sqrt(0.0001).*normrnd(0,pars.noiseStd) +  Ptemp(ii);
end
dydt=dydt';

end
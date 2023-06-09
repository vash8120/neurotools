function dInoiseDt = coloredNoise(tspan,Inoise,pars)
tauS=pars.tauS;
sigma=pars.sigma;
tauM=pars.tauM;
dt=pars.dt;

En = sigma.*tauM.*(sqrt(dt)).*randn(1);

dInoiseDt = (1./tauS).*(En - Inoise);

end
function [t,thetavec]=pcomodel()

pars.fvec = [10,10,10,10,10,10];
pars.A = [1,1,1,0,0,0;
    1,1,0,1,0,0;
    1,0,1,1,1,0;
    0,1,1,1,0,1;
    0,0,1,0,1,1;
    0,0,0,1,1,1];
pars.thetapref = [0,pi,pi,0,0,pi;
             -pi,0,0,-pi,-pi,0;
             -pi,0,0,-pi,-pi,0;
             0,pi,pi,0,0,pi;
             0,pi,pi,0,0,pi;
             -pi,0,0,-pi,-pi,0];
pars.K=1500;

% tt = 0:0.001:10;

ton=155;
toff=155.15;

pars.Pin = @(t) [0,0,0,5*(heaviside(t-ton)-heaviside(t-toff)),0,0,0];

pars.noiseStd=0.00;

x0 = [0,pi,pi,0,0,pi]+0.01*randn(1,6);
% tspan=[0:0.001:10];
tspan=[0:0.0001:10];

% [t,thetavec]=ode45(@(t,thetavec) pcodt(t,thetavec,pars),tspan,x0);
% [t,thetavec]=ode23s(@(t,thetavec) pcodt(t,thetavec,pars),tspan,x0);
[t,thetavec]=ode113(@(t,thetavec) pcodt(t,thetavec,pars),tspan,x0);

plot(t,wrapTo2Pi(thetavec))
figure
plot(wrapTo2Pi(thetavec(:,1)),wrapTo2Pi(thetavec(:,2)))

end

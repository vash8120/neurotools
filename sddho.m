function [x,t]=sddho(m,k,g,T,tspan)
%[x,t]=sddho(m,k,g,T,tspan)
x0=[0;0];
Kb = 1.38e-23;
[t,x]=ode45(@(t,x) [x(2);(1./m).*((-k.*x(1))+(-g.*x(2))+(((2.*Kb.*T.*g).^0.5).*(randn(1))))],tspan,x0);

D=Kb.*T./g
omega0=sqrt(k./m);
tau=m./g
zeta = 1./(2.*omega0.*tau)

ax(1)=subplot(2,1,1);
plot(t,x(:,1))
ylabel('position')
ax(2)=subplot(2,1,2);
plot(t,x(:,2))
ylabel('velocity')
linkaxes(ax,'x');


end
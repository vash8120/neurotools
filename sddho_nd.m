function [x,t]=sddho_nd(zeta,tspan,x0)
%[x,t]=sddho_nd(zeta,tau,tspan)
%x0=[0;1];
[t,x]=ode45(@(t,x) [x(2);(-x(1)./(4.*(zeta.^2)))+(-x(2))+(randn(1)./(zeta.*sqrt(2)))],tspan,x0);

ax(1)=subplot(2,1,1);
plot(t,x(:,1))
ylabel('position')
ax(2)=subplot(2,1,2);
plot(t,x(:,2))
ylabel('velocity')
linkaxes(ax,'x');
% 
% figure
% for jj=1:100
% clf;circleplot(10*x(1,jj),0,0.1);xlim([-1,1]);axis equal;pause(0.01);
% end
end
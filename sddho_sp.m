function [x,t]=sddho_sp(dt,omega,gamma,D,tsim,x0)
%[x,t]=sddho_sp(dt,omega,gamma,D,tsim,x0)
%[x,t]=sddho_sp(1/60,2*pi*1.5,20,2.7e6,10,[0,1])

x=x0;
Nsim = tsim./dt;
for jj=1:Nsim
    x(jj+1,1)=x(jj,1)+(x(jj,2).*dt);
    x(jj+1,2)=((1-(gamma.*dt)).*x(jj,2))+(-(omega.^2).*x(jj,1).*dt)+randn(1).*sqrt(D.*dt);
end
t=0:dt:tsim;
% figure;for jj=1:600
% clf;circleplot(x(jj,1),0,10);xlim([-100,100]);axis equal;pause(1/60);
% end
end
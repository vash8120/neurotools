function [vm_all,t_all,te_all]=izhikevich(a,b,c,d,Iin,tspan,dt)
%[vm_all,t_all,te_all]=izhikevich(a,b,c,d,Iin,tspan,dt)
%[vm_all,t_all,te_all]=izhikevich(0.02,0.25,-55,0.05,@(z) 6,[0,4000],0.1)
%[vm_all,t_all,te_all]=izhikevich(0.02,0.2,-50,2,@(z) 10,[0,4000],0.1)
%[vm_all,t_all,te_all]=izhikevich(0.01,0.2,-65,5,@(z) 20,[0,4000],0.1)
%[vm_all,t_all,te_all]=izhikevich(0.01,0.2,-65,5,@(z) 20.*(heaviside(z-1000)-heaviside(z-2000)),[0,4000],0.1)
%[vm_all,t_all,te_all]=izhikevich(0.03,0.25,-52,0,@(z) -5.*(heaviside(z-1000)-heaviside(z-2000)),[0,4000],0.1)
%[vm_all,t_all,te_all]=izhikevich(0.03,0.25,-60,4,@(z) 2.3.*(heaviside(z-1000)-heaviside(z-2000)),[0,4000],1)
%[vm_all,t_all,te_all]=izhikevich(0.02,0.2,-55,4,@(z) 10.*(heaviside(z-1000)-heaviside(z-2000)),[0,4000],0.1)
%[vm_all,t_all,te_all]=izhikevich(1,1.5,-60,0,@(z) -65.*(heaviside(z-1000)-heaviside(z-2000)),[0,4000],0.05)
% [vm_all,t_all,te_all]=izhikevich(0.01,0.2,-65,8,@(z) 30.*(heaviside(z-1000)-heaviside(z-2000)),[0,4000],0.05)

x0=[c;b*c];

opts=odeset('Events',@spikethreshEvent);

tNow=0;
t_all=[];
vm_all=[];
te_all=[];
while tNow<(tspan(end)-dt)
    [t,x,te]=ode45(@(t,x) [((0.04.*(x(1).^2))+(5.*x(1))+(140)-(x(2))+Iin(t));a.*(b.*x(1)-x(2))],[tNow:dt:tspan(end)],x0,opts);
    vm=x(:,1);
    tNow=t(end);
    t_all=[t_all;t];
    te_all=[te_all;te];
    x0=[c;x(end,2)+d];
    vm_all=[vm_all;vm];
end

end
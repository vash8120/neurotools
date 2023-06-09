% Created by Eugene M. Izhikevich, February 25, 2003
% Excitatory neurons    Inhibitory neurons
% Ne=1;                 Ni=0;
% re=rand(Ne,1);          ri=rand(Ni,1);
a=[1];
b=[1.5];
c=[-60];
% d=[8-6*re.^2;           2*ones(Ni,1)];
d=[0];
% S=0*[0.5*rand(Ne+Ni,Ne),  -rand(Ne+Ni,Ni)];


v=c;
u=b.*v;                 % Initial values of u
firings=[];             % spike timings

jj=0;
dt=0.05;
for t=1:dt:1000            % simulation of 1000 ms
    jj=jj+1;
%   I=[5*randn(Ne,1);2*randn(Ni,1)]; % thalamic input
  I = 26.1.*(heaviside(t-250)-heaviside(t-750));
  fired=find(v>=30);    % indices of spikes
  firings=[firings; t+0*fired,fired];
  v(fired)=c(fired);
  u(fired)=u(fired)+d(fired);
  I=I;
  v=v+dt*(0.04*v.^2+5*v+140-u+I); % step 0.5 ms
%   v=v+dt*(0.04*v.^2+5*v+140-u+I); % for numerical
  u=u+dt*(a.*(b.*v-u));                 % stability
  vm(jj)=v;
  tm(jj)=t;
end;
plot(firings(:,1),firings(:,2),'.');
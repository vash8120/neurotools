function [u,t,spiketimes]=noisyIF(Idet,t,R,tauM,sigma, dt,thresh)
%[u,t]=noisyIF(Idet,t,R,tauM,sigma, dt,thresh)
%noisyIF(@sin,[0:0.01:100],1,1,1,0.1,0.95)
u=zeros(length(t),1);
du=zeros(length(t),1);
st=0;
for jj=1:length(t)
    du(jj)=((-u(jj)+(R*Idet(t(jj)))).*dt./tauM)+(sigma.*(sqrt(dt)).*randn(1));
    u(jj+1)=u(jj)+du(jj);
    if u(jj+1)>thresh
        u(jj)=10;
        u(jj+1)=0;
        st=st+1;
        spiketimes(st)=t(jj);
    end
end
u=u(1:end-1);
figure
ax(1)=subplot(2,1,1)
plot(t,u);
hold on
plot(spiketimes,10*ones(size(spiketimes)),'*r')
ylim([-4,15])
ax(2)=subplot(2,1,2)
rasterplot({spiketimes})
ylim([0.5,1.5])
linkaxes(ax,'x')
end

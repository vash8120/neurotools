function [c]=serialCorrCoeff(spiketimes)
% serial correlation coefficients

% In experiments, the renewal hypothesis can be tested by measuring
% the correlation between subsequent intervals. Under some experimental conditions, corre-
% lations are small, indicating that a description of spiking as a stationary renewal process
% is a good approximation

% Spike-frequency adaptation causes a negative correlation between subsequent intervals

isi = diff(spiketimes);

for kk=1:length(isi)
    sum1=0;
    sum2=0;
    sum3=0;
    sum4=0;
    n1=0;n2=0;n3=0;n4=0;
    for jj=1:(length(isi)-kk)
        sum1 = sum1+(isi(jj+kk)*isi(jj));
        n1=n1+1;
        sum2 = sum2+isi(jj);
        n2=n2+1;
        sum3 = sum3+((isi(jj)).^2);
        n3=n3+1;
        sum4 = sum4+isi(jj);
        n4=n4+1;
    end
    sum1 = sum1./n1;
    sum2 = ((sum2)./n2).^2;
    sum3 = sum3./n3;
    sum4 = (sum4./n4).^2;
    c(kk) = (sum1-sum2)./(sum3-sum4);
end

figure
plot(spiketimes(1:end-1),c,'o-')
xlabel('spike times')
ylabel('serial correlation coefficients')

figure
plot(isi(1:end-1),isi(2:end),'*');
xlabel('isi(j)')
ylabel('isi(j+1)')



end
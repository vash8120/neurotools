function rasterplot(spiketrains)

for kk=1:length(spiketrains)
    spiketimes = cell2mat(spiketrains(kk));
    for jj=1:length(spiketimes)
        line([spiketimes(jj),spiketimes(jj)],[kk-0.25,kk+0.25])
    end
end
end
function plotData(rawData,times)
%%% plot the raw data

figure(1)
clf()
subplot(2,2,1)
plot(times,rawData(1,:))
hold on
plot([0 max(times)], [0 0], 'k--')
hold off
title('Channel 0')
ylabel('Voltage')
xlabel('Time')

subplot(2,2,2)
plot(times,rawData(2,:))
hold on
plot([0 max(times)], [0 0], 'k--')
hold off
title('Channel 1')
ylabel('Voltage')
xlabel('Time')

subplot(2,2,4)
plot(times,rawData(3,:))
hold on
plot([0 max(times)], [0 0], 'k--')
hold off
title('Channel 2')
ylabel('Voltage')
xlabel('Time')

subplot(2,2,3)
plot(times,rawData(4,:))
hold on
plot([0 max(times)], [0 0], 'k--')
hold off
title('Channel 3')
ylabel('Voltage')
xlabel('Time')

end
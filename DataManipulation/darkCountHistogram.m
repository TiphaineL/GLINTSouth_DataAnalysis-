function [Mean, standDev] =  darkCountHistogram(darks,doPlot)
%%% Plot a histogram of the different dark channels and fit a Gaussian
%%% distribution to them

Mean = zeros(4,1);
standDev = zeros(4,1);

f = figure
for i=1:4
    [counts, bins, Mean_i, standDev_i] = fitNormHist(darks(i,:));
    Mean(i,:) = Mean_i;
    standDev(i,:) = standDev_i;
    gaussian = normPDF([Mean_i, standDev_i], bins(1:end-1));
    subplot(2,2,i)
    hold on
    plot(bins(1:end-1),counts,'DisplayName',['Dark ch' num2str(i)])
    plot(bins(1:end-1),gaussian,'k',...
        'DisplayName','Fitted Normal Distribution')
    hold off
    legend('show')
    if doPlot == false
        set(f, 'Visible', 'off')
    end
end

end

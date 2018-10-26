function [counts, bin, Mean, standDev] =  fitNormHist(data)
%%% Plot a histogram of the different dark channels and fit a Gaussian
%%% distribution to them

x0 = [mean(data),std(data)];

%%% Makes histogram of the different channels
[counts, bin] = histcounts(data,'Normalization','pdf');

%%% Fit a Gaussian distribution with the estimated mean and std
[Mean, standDev] = fitGaussian(bin,counts,x0);
end

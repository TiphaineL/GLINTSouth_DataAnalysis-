function [mean, standDev] = fitGaussian(bin, hist,x0)
%%% Fit a Gaussian distribution to the  data in order to 
%%% retrieve the mean value and the standard deviation as well
%%% as isolating 'bad' points

% lb = [-Inf, 0];
% ub = [+Inf,+Inf];

fitfunction = @(p,x) normPDF([p(1),p(2)],x);

fittedParam = lsqcurvefit(fitfunction,x0,bin(1:end-1),hist);

mean = fittedParam(1);
standDev = fittedParam(2);

end

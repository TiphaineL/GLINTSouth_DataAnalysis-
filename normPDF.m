function y = normPDF( x,mean,stdDev )
% returns the normal distribution of x 
% with mean mean and standard deviation stdDev

y = (1 / (sqrt(2*pi)*stdDev)).* exp(-(x-mean).^2/(2*stdDev^2));
end


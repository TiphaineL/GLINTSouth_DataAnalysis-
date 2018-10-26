function y = normPDF( p,x )
% returns the normal distribution of x 
% with mean mean and standard deviation stdDev
mean = p(1);
stdDev = p(2);

y = (1 / (sqrt(2*pi)*stdDev)).* exp(-(x-mean).^2/(2*stdDev^2));
end


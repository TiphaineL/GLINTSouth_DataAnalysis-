function  y  = normQuad( x, mean, stdDev )
% Normal Pobability Distribution Function for quadratic values
% with mean mean and standard deviation stDev
% PDF(x<0) = 0

c = find(x<=0);

y = exp(-(2*sqrt(x)-mean).^2/(2*stdDev^2)) ./ ...
    (sqrt(2*pi*x)*stdDev);

y(c) = 0;



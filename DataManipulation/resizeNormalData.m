function newData = resizeNormalData(mean, standDev, n)
%%% From a normal known distribution of mean mean and standard deviation
%%% std generate n random numbers

newData = standDev * randn(n,1) + mean;
end
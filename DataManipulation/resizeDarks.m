function newData = resizeDarks(mean, standDev, n)

newData = zeros(4,n);
for i = 1:4
    newData(i,:) = resizeNormalData(mean(i,1),standDev(i,1),n);
end
end

    
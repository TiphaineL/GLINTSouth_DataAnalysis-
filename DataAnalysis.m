clear all
close all

addpath('/import/pendragon1/snert/Tiphaine/GLINTSouth_DataAnalysis-/DataManipulation/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% swapChs23 = false; %Set to true to swap the null and anti-null channel
% 
% histAxes = [-0.2, 1.2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plotRawData = false;
plotDataDistribution = false;
 

%%% Get the input files desired
[filePath,...
 filePrefix,...
 startTime,...
 endTime,...
 darkFilesSpecify] = get_input;

%%% Extract the data (raw channel data, raw darks, format time)
[rawData,...
 times,...
 darks] = extractData(filePath,filePrefix,startTime,endTime,darkFilesSpecify);


if plotRawData
    plotData(rawData,times)
end

%%% Display the average intensity in each channels with the average dark 
%%% substracted
displayAverageCounts(rawData- mean(darks,2))

%%% Fit the different variable mean and standard deviation from a normal 
%%% distribution and plot the distribution with the fit for check
variables = fitVariableDistributions(rawData,darks,plotDataDistribution)


[binCents,histVals] = doHist(rawData,variables);


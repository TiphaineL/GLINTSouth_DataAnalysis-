function [binCents,histVals] = doHist(data,variables)
%%% This function plot and organise the data as histogram

%addpath('/import/pendragon1/snert/Tiphaine/GLINTSouth_DataAnalysis-/Null_stat_model/');

histNBins=5000; %200; % Number of bins for the histogram

%%% The null estimate is the ratio of the null channel over the antinull
%%% channel
nullEst = data(2,:)./data(3,:);

% Manually specify histogram bins
maxXVal = 1.2;
minXVal = -1.2;
histBinSize = (maxXVal-minXVal)/(histNBins);
histEdgesSpecify = minXVal:histBinSize:maxXVal;

[histVals, histBins, binInds]=histcounts(nullEst,histEdgesSpecify);
histErr = sqrt(histVals);
binWidth = histBins(3) - histBins(2);
binCents = histBins(1:end-1)+binWidth/2;

normCoeff = sum(histVals)*binWidth;
histVals = histVals/normCoeff;
histErr = histErr/normCoeff;
weights = 1./(std(histErr)).^2;
%weights = 1;

%%% Chip throughput coefficients, measured by Tiph @USyd lab 2018/09/03
ch1ToNullRatio = .37; % Tiph measured in lab 2018 09 03
ch4ToNullRatio = .43;
ch1ToNullRatio = .3;
ch4ToNullRatio = .3;

% %%% Use the chip coefficients to estimate I1 and I2 feeding the coupler
% phot1 = data(1,:) * (1/ch1ToNullRatio -1);
% phot1 = phot1;
% phot1(phot1 <= 0) = 1e-14; 
% %This is actually problematic, since can be negative from noise
% phot2 = data(4,:) * (1/ch4ToNullRatio -1);
% phot2 = phot2;
% phot2(phot2 <= 0) = 1e-14; 
% 
% 
% %%% Fit model to the histogram data
% dI = (phot1 - phot2) ./ (phot1 + phot2);
% mean_dI = mean(dI);
% stdDev_dI = std(dI);
% mean_Dark = 0;

x0 = [.1,.1,.1];
lb = [0,-Inf,0]; %lower bounds
ub = []; % upper bounds

options = optimoptions('lsqcurvefit','Display','iter-detailed');

% %fitfunction = @(p,x) null_PDF([p(1:3),mean_dI,stdDev_dI,mean_Nb,p(4)],x);
% fitParam = lsqnonlin(@(p) weights.*(null_PDF([p(1:3),mean_dI,stdDev_dI,...
%     mean_Dark,p(4)],binCents) - histVals), x0, lb, ub, options)

fitParam = lsqnonlin(@(p) weights.*(null_PDF([p(1:3),...
                                              variables(2,1),...
                                              variables(2,2),...
                                              variables(3,1),...
                                              variables(3,2)],...
                             binCents) - histVals), x0, lb, ub, options)


% [data_fit_param,resnorm,residual,exitflag,output] = ...
%    lsqcurvefit(fitfunction,x0,binCents,histVals,lb,ub,options);

param = [ fitParam(1:3),...
          variables(2,1),...
          variables(2,2),...
          variables(3,1),...
          variables(3,2) ];

      fitted = null_PDF(param,binCents);

figure()
hold on
%errorbar(binCents,histVals,histErr)
xAreaPlot = [binCents, fliplr(binCents)];
inBetween = [histVals - histErr, fliplr(histVals + histErr)];
confidence = fill(xAreaPlot, inBetween,'k','DisplayName',...
    'Measured Null Depth distribution confidence interval');
set(confidence,'facealpha',0.5,'EdgeColor','none')
plot(binCents,fitted,'k','DisplayName','Fitted Null Depth distribution')
legend('show')

% Display the fitted parameters
disp(['Na = ' num2str(param(1)) ' %'])
disp(['mean Delta_phi = ' num2str(param(2))])
disp(['std Delta_phi = ' num2str(param(3))])
disp(['mean dI = ' num2str(param(4))])
disp(['std dI = ' num2str(param(5))])
disp(['std Nb = ' num2str(param(7))])

%%% Goodness of fit
res =  histVals - fitted;
var_res = sum( (res - mean(res)).^2 ) /(length(res)-1);
chi_square = sum( res.^2 / var_res);
chi_square_nu = chi_square / (length(fitted - length(x0)));

disp(['chi squared = ' num2str(chi_square_nu)])

end

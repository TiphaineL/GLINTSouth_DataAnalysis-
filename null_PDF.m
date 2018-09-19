function tot_PDF = null_PDF( p,x )
% Returns the theoretical Probability Distribution Function 
% of the astronomical null Depth
% 
% Na: the astronomical null depth/'true' null depth (normal PDF)
% Dphi: the phase difference phi2 - phi1 (quadradic PDF)
% dI: fractional deviation from the mean intensity 
%     dI = (I1 - I2) / (I1 + I2)  (quadratic PDF)
% Nb: Background noise (norm PDF)

%%% Parameters p
mean_Na = p(1);

mean_Dphi = p(2);
stdDev_Dphi = p(3);

mean_dI = p(4);
stdDev_dI = p(5);

mean_Nb = p(6);
stdDev_Nb = p(7);

%%% Distributions of the parameters
Dphi_PDF = normQuad(x,mean_Dphi,stdDev_Dphi);
Dphi_PDF = Dphi_PDF / max(Dphi_PDF);

dI_PDF = normQuad(x,mean_dI,stdDev_dI);
dI_PDF = dI_PDF / max(dI_PDF);

dI_Dphi_PDF = conv(Dphi_PDF,dI_PDF,'same');
dI_Dphi_PDF = dI_Dphi_PDF / max(dI_Dphi_PDF);

% Na_PDF = normPDF(x,mean_Na,stdDev_Na);
% Na_PDF = Na_PDF / max(Na_PDF);

% c = find(x <= mean_Na);
% dI_Dphi_Na_PDF = dI_and_Dphi_PDF;
% dI_Dphi_Na_PDF(x >= mean_Na) = dI_and_Dphi_PDF(1:length(x)-max(c));
% dI_Dphi_Na_PDF(x < mean_Na) = 0;

% dI_Dphi_Na_PDF = conv(dI_Dphi_PDF,Na_PDF,'same');
% dI_Dphi_Na_PDF = dI_Dphi_Na_PDF / max (dI_Dphi_Na_PDF);

Nb_PDF = normPDF(x,0,stdDev_Nb);
Nb_PDF = Nb_PDF/max(Nb_PDF);

tot_PDF = conv(dI_Dphi_PDF,Nb_PDF,'same');
tot_PDF = tot_PDF/max(tot_PDF);

%xq = x(1):(abs(x(2)-x(1))/100):x(end);
tot_PDF = interp1(x,tot_PDF,x);

%%% Shift the data by mean Na
% First find x=0
a = find (x<0);
a = max(a);
% Find x = Na
c = find(x < mean_Na);
c = max(c);
c = c-a; % Removing the negative x's

tot_zeros = zeros(1,length(tot_PDF));
tot_zeros(c+1:end) = tot_PDF(1:end-c);

tot_PDF = tot_zeros;
tot_PDF = tot_PDF / (sum(tot_PDF) * abs(x(2)-x(1)));

% figure(1)
% hold on
% plot(x,Dphi_PDF,'DisplayName','Dphi')
% plot(x,dI_PDF,'DisplayName','dI')
% plot(x,dI_Dphi_PDF,'DisplayName','Dphi x dI')
% plot(x,Nb_PDF,'DisplayName','Nb')
% plot(x,tot_PDF,'DisplayName','Dphi x dI x Na x Nb')
% xlim([-.04 .1])
% ylim([0,1])
% legend('show')
end


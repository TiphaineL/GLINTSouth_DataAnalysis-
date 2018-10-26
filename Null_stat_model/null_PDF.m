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

Nb_PDF = normPDF([0,stdDev_Nb],x);
Nb_PDF = Nb_PDF/max(Nb_PDF);

tot_PDF = conv(dI_Dphi_PDF,Nb_PDF,'same');
%tot_PDF = dI_Dphi_PDF;

x_shift_Na = x + mean_Na;
tot_PDF = interp1(x_shift_Na,tot_PDF,x);
tot_PDF(find(isnan(tot_PDF))) = 0;
tot_PDF = tot_PDF/(sum(tot_PDF)*abs(x(2)-x(1)));

% figure(1)
% hold on
% plot(x,Dphi_PDF,'r','DisplayName','Dphi')
% plot(x,dI_PDF,'y','DisplayName','dI')
% plot(x,dI_Dphi_PDF,'g','DisplayName','Dphi x dI')
% plot(x,Nb_PDF,'c','DisplayName','Nb')
% plot(x,tot_PDF,'b','DisplayName','Dphi x dI x Na x Nb')
% xlim([-.04 .1])
% ylim([0,1])
% legend('show')
end



%%% Test fitting the Null_PDF to noise generated fake data

clear all 
clc
close all

% Null Depth values axis
x = [-.5:1e-4:.5];

%%% create a PDF function to fit with variables var

Na = 0.015;
Dphi = .35;
sig_Dphi = .41;
dI = -.06;
sig_dI = .12;
Nb = 0;
sig_Nb = .05;

var = [Na,Dphi,sig_Dphi,dI,sig_dI,Nb,sig_Nb];

tot_PDF = null_PDF(var,x);

%%% add some noise (normally distributed
sigma = .05;
fake_noisy =tot_PDF+randn(1,numel(tot_PDF)).*sigma;   

%%% x0 the initial conditions for the fitting
x0 = [0.001,0.1,0.1,0.005];

%%% Boundary conditions for the fitting
lb = [0,-Inf,0,0];
ub = [+Inf,+Inf,+Inf,+Inf]; 

% lb = [];
% ub = [];

%%% Other fitting options
options = optimoptions('lsqcurvefit','FinDiffRelStep',...
         [0.0001,0.0001,0.0001,0.0001],...
         'TolX',1e-6,'TolFun',1e-6,...
         'Display','iter-detailed');

fitfunction = @(p,x) null_PDF([p(1:3),var(4:6),p(4)],x);

[x_pp,resnorm,residual,exitflag,gof,output] = lsqcurvefit(...
   fitfunction,x0,x,fake_noisy,lb,ub,options);

% Display the exitflag and the goodness of fit parameters
exitflag
%gof

x_pp = [x_pp(1:3),var(4:6),x_pp(4)];
sol = null_PDF(x_pp,x);

% Display the fitted parameters
disp(['Na = ' num2str(x_pp(1)) ' %'])
disp(['mean Delta_phi = ' num2str(x_pp(2))])
disp(['std Delta_phi = ' num2str(x_pp(3))])
disp(['mean dI = ' num2str(var(4))])
disp(['std dI = ' num2str(var(5))])
disp(['std Nb = ' num2str(x_pp(4))])

%%% Goodness of fit
res = fake_noisy - sol;
var_res = sum( (res - mean(res)).^2 ) /(length(res)-1);
chi_square = sum( res.^2 / var_res);
chi_square_nu = chi_square / (length(fake_noisy - length(x0)));

disp(['chi squared = ' num2str(chi_square_nu)])

figure(2)
hold on
plot(x,tot_PDF,'k','DisplayName','Analytical PDF')
% % xlim([-.04 1])
plot(x,fake_noisy,'r','DisplayName','Analytical PDF + noise')
plot(x,fake_noisy - null_PDF(x_pp,x),'g','DisplayName',...
    'Residual Noisy data - Fitted data')
plot(x,sol,'--b','DisplayName','Fitted PDF')
legend('show') 


%%% Test fitting the Null_PDF to noise generated fake data

clear all 
clc
close all

% Null Depth values axis
x = [-.5:1e-5:.5];

%%% create a PDF function to fit with variables var

Na = 0.01;
sig_Na = 0.0001;
Dphi = .02;
sig_Dphi = .15;
dI = -.2;
sig_dI = .3;
Nb = 0;
sig_Nb = .015;

var = [Na,sig_Na,Dphi,sig_Dphi,dI,sig_dI,Nb,sig_Nb];

tot_PDF = null_PDF(var,x);

%%% add some noise (normally distributed
sigma = .2;
fake_noisy =tot_PDF+randn(1,numel(tot_PDF)).*sigma;   

%%% x0 the initial conditions for the fitting
x0 = [0.02,0.2,0.2,0.01];

%%% Boundary conditions for the fitting
lb = [0,-Inf,0,0];
ub = [+Inf,+Inf,+Inf,+Inf]; 

lb = [];
ub = [];

%%% Other fitting options
options = optimoptions('lsqcurvefit','FinDiffRelStep',...
         [0.0001,0.0001,0.0001,0.0001],...
         'TolX',1e-5,'TolFun',1e-5,...
         'Display','iter-detailed');

fitfunction = @(p,x) null_PDF([p(1),var(2),p(2:3),var(5:7),p(4)],x);

[x_pp,resnorm,residual,exitflag,output] = lsqcurvefit(...
   fitfunction,x0,x,fake_noisy,lb,ub,options);

exitflag

x_pp = [x_pp(1),var(2),x_pp(2:3),var(5:7),x_pp(4)];
sol = null_PDF(x_pp,x);

x_pp

figure(2)
hold on
plot(x,tot_PDF,'y')
xlim([-.04 .08])
plot(x,fake_noisy,'r')
plot(x,fake_noisy - null_PDF(x_pp,x),'g')
plot(x,sol,'--b')
%plot([0.01 0.01],[0 20],'r')
plot(x,fake_noisy - tot_PDF,'m')
legend(['Analytical PDF'],['Analytical PDF + noise'],...
       ['Residual Analytical noisy PDF - Analytical PDF'],...
       ['Fitted PDF'],['Residual fitted PDF - Analytical PDF']) 

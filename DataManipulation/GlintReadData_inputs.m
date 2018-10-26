function [filePath,filePrefix,startTimeString,endTimeString,...
    darkFileSpecify] = get_input
%%% Ugly function, but modify this file to select the right data set to 
%%% analyse

clear all
close all

darkFilesSpecify = {};

%addpath('/import/pendragon1/snert/Tiphaine/USyd_LabTests/codes/GLINTSouth_DataAnalysis-/');

%%% LAB DAT - USyd SAIL 

% %%% Chip coefficients measurements
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/chipCoeff/';
% filePrefix = 'acqdata_';
% 
% %tunable laser
% % dark
% startTimeString = '20181015T125154';
% endTimeString = '20181015T125317';
% manualDarkSpecify = [0.-0.0113, -0.0211, -0.1027, 0.0045];
% %ch1
% startTimeString = '20181015T125451';
% endTimeString = '20181015T125655';
% % % ch4 
% startTimeString = '20181015T125745';
% endTimeString = '20181015T125907';

% %ch1
% startTimeString = '20180903T151039';
% endTimeString = '20180903T152641';
% % ch4 0.5mw?
% startTimeString = '20180903T152839';
% endTimeString = '20180903T153317';
% % ch4 .84mW
% startTimeString = '20180903T173552';
% endTimeString = '20180903T174135';
% % ch4 1.40mW
% startTimeString = '20180903T174301';
% endTimeString = '20180903T174814';
% % ch4 2.73mW
% startTimeString = '20180903T174930';
% endTimeString = '20180903T175329';


% %%% Tunable Laser 2018 05 03
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/LaserTun/Pwni/';
% filePrefix = 'acqdata_';
% %%% 1510nm
% startTimeString = '20180511T173819';
% endTimeString = '20180511T173907';
% %%% 1520nm
% startTimeString = '20180511T174838';
% endTimeString = '20180511T174919';
% %%% 1530nm
% startTimeString = '20180511T181448';
% endTimeString = '20180511T181530';
% %%% 1540nm
% startTimeString = '20180511T182657';
% endTimeString = '20180511T182738';
% %%% 1550nm
% startTimeString = '20180511T184304';
% endTimeString = '20180511T184354'; 
% %%% 1560nm
% startTimeString = '20180511T184632';
% endTimeString = '20180511T184713';
% %%% 1570nm
% startTimeString = '20180511T185316';
% endTimeString = '20180511T185357';
% %%% 1580nm
% startTimeString = '20180511T185944';
% endTimeString = '20180511T190025';
% %%% 1590nm
% startTimeString = '20180511T190626';
% endTimeString = '20180511T190707';
% %%% 1600nm
% startTimeString = '20180511T191458';
% endTimeString = '20180511T191540';
% %%% 1610nm
% startTimeString = '20180511T192117';
% endTimeString = '20180511T192215';
% %%% 1620nm
% startTimeString = '20180511T193742';
% endTimeString = '20180511T193832';
% %%% 1630nm
% startTimeString = '20180511T194136';
% endTimeString = '20180511T194226';


% %%% wiggler different strengths
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Wiggler/';
% filePrefix = 'acqdata_'; 
% % 0
% startTimeString = '20180419T173229';
% endTimeString = '20180419T173316';
% % 0.01
% startTimeString = '20180419T173436';
% endTimeString = '20180419T173555';
% % 0.02
% startTimeString = '20180419T173630';
% endTimeString = '20180419T173717';
% % 0.03
% startTimeString = '20180419T173747';
% endTimeString = '20180419T173834';
% % 0.04
% startTimeString = '20180419T173914';
% endTimeString = '20180419T174000';
% % 0.05
% startTimeString = '20180419T174033';
% endTimeString = '20180419T174120';


%%% Data set check wiggler vs no wiggler
filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Wiggler/';
filePrefix = 'acqdata_'; 
% % no wiggler SLD
% startTimeString = '20180418T161615';
% endTimeString = '20180418T161703';
% %wiggler SLD
% startTimeString = '20180418T170136';
% endTimeString = '20180418T170223';
% %wiggler SLD only, no T/T new fiber (no fiber splitter)
% startTimeString = '20180418T174925';
% endTimeString = '20180418T175041';
% % % no wiggler Plasmasaurus
% startTimeString = '20180418T104811';
% endTimeString = '20180418T104857';
% % wiggler Plasmasaurus
% startTimeString = '20180418T104918';
endTimeString = '20180418T105024';
% wiggler T/T off PLasmasaurus
startTimeString = '20180418T173624';
endTimeString = '20180418T173757';


%%% Detector modes
% %%% Sydney 2018 - Tiph det tests 
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Det_2/';
% filePrefix = 'acqdata_';
% %%% Det: L, 10^10, SLD 400mA
% startTimeString = '20180326T173810';
% endTimeString = '20180326T174027';
% %%% Det: L, 10^10, SLD 440nm
% startTimeString = '20180326T175421';
% endTimeString = '20180326T175644';
%%% Det: L, 10^11, SLD ...
% startTimeString = '20180326T180441';
% endTimeString = '20180326T180636';
% %%% Sydney 2018 - Barnaby det tests 
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Det_lownoise_higain/';
% %%% 10V low Gain
% filePrefix = 'acqdata_10VLoGain_';
% startTimeString = '20180302T170937';
% endTimeString = '20180302T171638';
% % %%% 10V High Gain
% % filePrefix = 'acqdata_10VHiGain_';
% % startTimeString = '20180302T165355';
% % endTimeString = '20180302T170617';
% % %%% 02V Low Gain
% % filePrefix = 'acqdata_02VLoGain_';
% % startTimeString = '20180302T171121';
% % endTimeString = '20180302T171453';


%%% Coupling
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Coupling/';
% filePrefix = 'acqdata_';
% %#1
% startTimeString = '20180904T135729';
% endTimeString = '20180904T140014';
%
% manualDarkSpecify = [0.0021341, 0.0022174, 0.0021719, 0.0023935];
% %#2 
% startTimeString = '20180904T141107';
% endTimeString = '20180904T141516';
% %#3
% startTimeString = '20180904T142205';
% endTimeString = '20180904T142531';
% %#4
% startTimeString = '20180904T143125';
% endTimeString = '20180904T143451';
% %#5
% startTimeString = '20180904T144147';
% endTimeString = '20180904T144513';
% %#6
% startTimeString = '20180904T145634';
% endTimeString = '20180904T150042';
% %#7
% startTimeString = '20180904T150845';
% endTimeString = '20180904T151254';
% %#8
% startTimeString = '20180904T151454';
% endTimeString = '20180904T151821';
% %#9
% startTimeString = '20180904T154238';
% endTimeString = '20180904T154808';

%%% Coupling  TEST 4 
%%% wiggler 0 0.05 0.05 and 0.05 0.05 0.05
%%% T/T loop on 
%%% Plasmasaurus
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Coupling/';
% filePrefix = 'acqdata_';
% %# 1 
% startTimeString = '20180419T154521';
% endTimeString = '20180419T154608';
% %# 2 
% startTimeString = '20180419T154919';
% endTimeString = '20180419T155006';
% %# 3
% startTimeString = '20180419T155236';
% endTimeString = '20180419T155323';
% %# 4 
% startTimeString = '20180419T155532';
% endTimeString = '20180419T155619';
% %# 5
% startTimeString = '20180419T155840';
% endTimeString = '20180419T160030';
% %# 6 
% startTimeString = '20180419T160542';
% endTimeString = '20180419T160629';
% %# 7
% startTimeString = '20180419T161030';
% endTimeString = '20180419T161117';
% %# 8 
% startTimeString = '20180419T161633';
% endTimeString = '20180419T161719';
% %# 9 
% startTimeString = '20180419T162003';
% endTimeString = '20180419T162050';
% %# 10 
% startTimeString = '20180419T162314';
% endTimeString = '20180419T162400';
% %# 11 
% startTimeString = '20180419T162658';
% endTimeString = '20180419T162744';

%%% Coupling TEST 3
% %# 1 
% startTimeString = '20180419T151119';
% endTimeString = '20180419T151207';
% %# 2 
% startTimeString = '20180419T151540';
% endTimeString = '20180419T151627';
% %# 3
% startTimeString = '20180419T151858';
% endTimeString = '20180419T151945';
% %# 4 
% startTimeString = '20180419T152205';
% endTimeString = '20180419T152251';
% %# 5
% startTimeString = '20180419T152446';
% endTimeString = '20180419T152533';
% %# 6 
% startTimeString = '20180419T152805';
% endTimeString = '20180419T152851';
% %# 7
% startTimeString = '20180419T153115';
% endTimeString = '20180419T153202';
% %# 8 
% startTimeString = '20180419T153403';
% endTimeString = '20180419T153449';
% %# 9 
% startTimeString = '20180419T153655';
% endTimeString = '20180419T153741';
% %# 10 
% startTimeString = '20180419T154002';
% endTimeString = '20180419T154049';
% %# 11
% startTimeString = '20180419T154248';
% endTimeString = '20180419T154335';

% %%% Coupling TEST 2
% %%%%%%%%%%%%% Sydney 2018 %%%%%%%%%%%%%%%%%
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Coupling/';
% filePrefix = 'acqdata_';
% %# 1 
% startTimeString = '20180306T165453';
% endTimeString = '20180306T165908';
% %# 2
% startTimeString = '20180306T170205';
% endTimeString = '20180306T170554';
% %# 3
% startTimeString = '20180306T170745';
% endTimeString = '20180306T171045';
% %# 4 
% startTimeString = '20180306T171254';
% endTimeString = '20180306T171604';
% %# 5 
% startTimeString = '20180306T172022';
% endTimeString = '20180306T172329';
% %# 6
% startTimeString = '20180306T172624';
% endTimeString = '20180306T172957';
% %# 7
% startTimeString = '20180306T173200';
% endTimeString = '20180306T173544';

% %%% Coupling TEST 1
% %%%%%%%%%%%%%% Sydney 2018 %%%%%%%%%%%%%%%%%
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Lab_coupling/';
% filePrefix = 'acqdata_';
% %# 1 
% startTimeString = '20180227T111451';
% endTimeString = '20180227T113123';
% endTimeString = '20180227T112223';
% %#2
% startTimeString = '20180227T120135';
% endTimeString = '20180227T121441';
% %# 3
% startTimeString = '20180227T122141';
% endTimeString = '20180227T123756';
% %#4 
% startTimeString = '20180227T124457';
% endTimeString = '20180227T125415';
% %# 5 
% startTimeString = '20180227T125835';
% endTimeString = '20180227T131224';
% %# 6
% startTimeString = '20180227T131908';
% endTimeString = '20180227T132905';
% %# 7
% startTimeString = '20180227T133151';
% endTimeString = '20180227T134142';
% %#8 
% startTimeString = '20180227T134405';
% endTimeString = '20180227T135356';
% %# 9 
% startTimeString = '20180227T135622';
% endTimeString = '20180227T140417';
% %#10
% startTimeString = '20180227T140825';
% endTimeString = '20180227T141929';
% %# 11
% startTimeString = '20180227T142338';
% endTimeString = '20180227T143121';
% %# 12
% startTimeString = '20180227T143447';
% endTimeString = '20180227T144433';


%%% Test fiber splitter
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/test splitter/';
% filePrefix = 'acqdata_';
% %Fiber splitter SLD + red laser
% startTimeString = '20180426T130728';
% endTimeString = '20180426T130841';
%Fiber splitter + single mode fiber SLD + red laser
% startTimeString = '20180426T131215';
% endTimeString = '20180426T131322';
% %plasmasaurus
% startTimeString = '20180426T132511';
% endTimeString = '20180426T132609';


% %%% Polarisation
% filePath = '/import/pendragon1/snert/Tiphaine/USyd_LabTests/Pol/';
% filePrefix = 'acqdata_';
% % 0
% startTimeString = '20180416T145248';
% endTimeString = '20180416T145346';
% % 10
% startTimeString = '20180416T145757';
% endTimeString = '20180416T145855';
% % 20
% startTimeString = '20180416T150301';
% endTimeString = '20180416T150400';
% % 30
% startTimeString = '20180416T150952';
% endTimeString = '20180416T151116';
% % 40
% startTimeString = '20180416T151439';
% endTimeString = '20180416T151555';
% % 50
% startTimeString = '20180416T152004';
% endTimeString = '20180416T152214';
% % 60
% startTimeString = '20180416T152555';
% endTimeString = '20180416T152653';
% % 70
% startTimeString = '20180416T153641';
% endTimeString = '20180416T153757';
% % 80
% startTimeString = '20180416T154100';
% endTimeString = '20180416T154159';
% % 90
% startTimeString = '20180416T154439';
% endTimeString = '20180416T154538';
% % 100
% startTimeString = '20180416T155607';
% endTimeString = '20180416T155731';
% % 110
% startTimeString = '20180416T160020';
% endTimeString = '20180416T160118';
% % 120
% startTimeString = '20180416T160535';
% endTimeString = '20180416T160642';
% % 130
% startTimeString ='20180416T160956';
% endTimeString = '20180416T161054';
% % 140
% startTimeString = '20180416T161338';
% endTimeString = '20180416T161437';
% % 150
% startTimeString = '20180416T161715';
% endTimeString = '20180416T161831';
% % 160
% startTimeString = '20180416T162105';
% endTimeString = '20180416T162204';
% % 170
% startTimeString = '20180416T162434';
% endTimeString = '20180416T162532';
% % 180
% startTimeString = '20180416T162910';
% endTimeString = '20180416T163009';
% % 190
% startTimeString = '20180416T163317';
% endTimeString = '20180416T163415';
% % 200
% startTimeString = '20180416T164804';
% endTimeString = '20180416T164902';
% % 210
% startTimeString = '20180416T165436';
% endTimeString = '20180416T165534';
% % 220
% startTimeString = '20180416T165849';
% endTimeString = '20180416T165948';
% % 230
% startTimeString = '20180416T170448';
% endTimeString = '20180416T170546';
% % 240
% startTimeString = '20180416T170932';
% endTimeString = '20180416T171031';
% % 250
% startTimeString = '20180416T171423';
% endTimeString = '20180416T171521';
% % 260
% startTimeString = '20180416T172208';
% endTimeString = '20180416T172307';
% % 270
% startTimeString = '20180416T172701';
% endTimeString = '20180416T172759';
% % 280
% startTimeString = '20180416T173229';
% endTimeString = '20180416T173336';
% % 290
% startTimeString = '20180416T173631';
% endTimeString = '20180416T173729';
% % 300
% startTimeString = '20180416T174034';
% endTimeString = '20180416T174133';
% % 310
% startTimeString = '20180416T174420';
% endTimeString = '20180416T174519';
% % 320
% startTimeString = '20180416T174819';
% endTimeString = '20180416T175026';
% % 330
% startTimeString = '20180416T175421';
% endTimeString = '20180416T175528';
% % 340
% startTimeString = '20180416T175833';
% endTimeString = '20180416T175936';
% % 350
% startTimeString = '20180416T180219';
% endTimeString = '20180416T180254';
% % 360
% startTimeString = '20180416T180638';
% endTimeString = '20180416T180745';


end

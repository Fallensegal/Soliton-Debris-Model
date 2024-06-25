% Original: Connor Wilson - Aug 2023
% Updated: Adrienne Rudolph - Jan 2024
% post processes soliton data and produce plots
close all
clear
clc

addpath(genpath('/Users/arudy/Documents/Adrienne/UMD/Research/Conner_Research/ThesisSoftwareWilson/'))

%select target and madrigal data file

%file = 'TISAT 1_2018_November_19_1'; MadFile = 'MAD6300_2018-11-19_tau7_60@42m.txt';

%% Madrigal Jun 15, SpaceTrack Jun 14th 2010
%file = 'CUBESAT XI-IV_2010_June_15_1'; MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt'; 
%file = 'CUBESAT XI-V_2010_June_15_2'; MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt';
%file = 'CUTE-1.7+APD II_2010_June_15_4'; MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt';
file = 'BEESAT_2010_June_15_5'; MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt';

%% Madrigal Dec 15, SpaceTrack Dec 14th 2007
%file = 'PICOSAT 4_2007_December_15_1'; MadFile = 'MAD6300_2007-12-15_tau7_60@42m.txt';

%% Madrigal May 11, SpaceTrack May 10, 2022
%file = 'CP4_2022_May_11_1'; MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';
%file = 'SWISSCUBE_2022_May_11_1'; MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';
%file = 'NANOSAT C BR1_2022_May_11_1'; MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';
%file = 'AEROCUBE 6A_2022_May_11_1'; MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';
%file = 'YARILO-2_2022_May_11_1'; MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';

%% Madrigal Dec 28, SpaceTrack Dec 27, 2022
%file = 'CANX-1_2022_December_28_1';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'CUBESAT XI 4_2022_December_28_2';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'GOMX 1_2022_December_28_3';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'XW-2E_2022_December_28_4';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'XW-2F_2022_December_28_5';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'SMOG-1_2022_December_28_9';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'SPACEBEE-117_2022_December_28_10';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';

%file = 'TEVEL 1_2024_January_12_1';MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';
%file = 'MOVE-II_2024_January_12_1';MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';
%file = 'QMR-KWT_2024_January_16_1';MadFile = 'MAD6300_2024-01-16_tau7_60@42m.txt';
%file = 'PROMETHEUS 2-1_2024_January_18_1';MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';
%file = 'M-CUBED/EXP-1 PRIME_2024_January_18_1';MadFile ='MAD6300_2024-01-18_tau7_60@42m.txt';%just dont use

%file = 'ESTCUBE 1_2024_January_18_1';MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';
%file = 'KOSEN-1_2024_January_18_1';MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';
%file = 'MDASAT-1C_2024_January_18_1';MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';
%file = 'SNUGLITE-II_2024_January_18_1';MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';
%file = 'SPACEBEE-160_2024_January_18_1';MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';

%file = 'ANDESITE_2024_January_12_1';MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';
%file = 'FLOCK 4S 1_2024_January_12_1';MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';
%file = 'FLOCK 4S 17_2024_January_12_1';MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';
%file = 'MOVE-II_2024_January_12_1';MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';
%file = 'AUBIESAT-1_2024_January_12_1';MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';
%file = 'SPACEBEENZ-16_2023_September_01_1';MadFile = 'MAD6300_2023-09-01_tau7_60@42m.txt';

%file = 'CSTB 1_2022_May_10_1';MadFile = 'MAD6300_2022-05-10_tau7_60@42m.txt';
%file = 'CP4_2022_May_11_1';MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';
%file = 'CANX-1_2022_December_28_1';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'CUBESAT XI 4_2022_December_28_1';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';
%file = 'GOMX 1_2022_December_28_1';MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt'; %this is 10x10x20
%file = 'MAKERSAT 0_2023_January_05_1';MadFile = 'MAD6300_2023-01-05_tau7_60@42m.txt';
%file = 'STRAND 1_2023_March_03_1';MadFile = 'MAD6300_2023-03-03_tau7_60@42m.txt'; %this is 10x10x34

%set constants
debrisRadius = 0.05; %size of the debris/CubeSats
plotIt = true;       %plot the results
ShrinkTable = true;  %this reduces the size of the radar dataset to be near 
                     %when the target should be overhead



%% --------------- No inputs past this point --------------- %%
%load cubesat data files, find time range, and set the radius we will use
%to observe the magintude and shape of the soliton
load([file '.mat'])
UTCrange = [TargetUTC(1) TargetUTC(end)];
ObersvationRadius = debrisRadius*20;

%parse radar data
[MadData] = ReadMadrigalDataFunction(['Data/Madrigal/' MadFile],UTCrange,ShrinkTable);
%extract desired variables
M_Alt = MadData.Alt(:,1); 
M_Time = MadData.TimeNumDuration(1,:);
M_UTC = MadData.Time(1,:);
M_ElcDen = MadData.AdjustUncorrectElectronDensity;
%%
fprintf('processing soliton \n')
%find the range cells that the target will pass through and select those
%datasets from the radar data
lla = ecef2lla(TargetStates(1,1:3));
AltKM = lla(:,3)/1000;
[~,AltIndex] = min(abs(M_Alt-AltKM));
ElectronDensitySeries = abs(MadData.AdjustUncorrectElectronDensity(AltIndex,:));
ElectronDensitySeriesReal = MadData.AdjustUncorrectElectronDensity(AltIndex,:);
ElectronDensityAverage = mean(ElectronDensitySeries);

%
t = tDim+0.0022*10^-4; %time of movement of CubeSat/debris
Uad = U*ElectronDensityAverage+ElectronDensityAverage; %electron density perturbation from the soliton
xyPosition = [norm(TargetStates(1,4:6))*t 0]; %position of the CubeSat/debris

%estimate exactly where the CubeSat is relative to the soliton
Dx = abs(xDim(1,1)-xDim(1,2));
Dy = abs(yDim(1,1)-yDim(2,1));
[~, Xindex] = min(abs(xDim(1,:)-xyPosition(1)));
Yindex = (length(yDim(:,1))/2)+1;

%estimate the size of the soliton observation
xStep = ceil(ObersvationRadius/Dx);
yStep = ceil(ObersvationRadius/Dy);

%estimate the y step size
if (Yindex + yStep) > length(yDim(:,1))
    yStep = length(yDim(:,1))-Yindex;
end

%estimate the indexes that will be used to surround the soliton
Xminindex = Xindex - xStep;
Xmaxindex = Xindex + xStep;
Yminindex = Yindex - yStep;
Ymaxindex = Yindex + yStep;
%extraact the dimensions of the observation area and the magnitude of each
%point for the countour plot
Xnew = xDim(Yminindex:Ymaxindex,Xminindex:Xmaxindex);
Ynew = yDim(Yminindex:Ymaxindex,Xminindex:Xmaxindex);
Unew = Uad(Yminindex:Ymaxindex,Xminindex:Xmaxindex);

%measure the peak soliton magnitude
Umax = max(max(Unew));

if plotIt
    %plot the soliton
    figure('DefaultAxesFontSize',14); hold on;
    scatter(xyPosition(1),xyPosition(2),200,'.k')
    plot([xyPosition(1)+debrisRadius;xyPosition(1)-debrisRadius],[xyPosition(2);xyPosition(2)],'k')
    plot([xyPosition(1);xyPosition(1)],[xyPosition(2)+debrisRadius;xyPosition(2)-debrisRadius],'k')
    map = contour(Xnew,Ynew,Unew);
    xlabel('X Position, m')
    ylabel('Y Position, m')
    c = colorbar('eastoutside');
    c.Label.String = 'Electron Density, m^{-3} ';
    legend('debris','debris size')
    
    %plot electron density measurements and predicted electron density
    figure('DefaultAxesFontSize',14); hold on;
    plot(M_Time,ElectronDensitySeries)
    plot([M_Time(1) M_Time(end)],[ElectronDensityAverage ElectronDensityAverage])
    plot([M_Time(1) M_Time(end)],[Umax Umax])
    plot([MadData.TimeBound(1)+1 MadData.TimeBound(1)+1],...
        [max(ElectronDensitySeries)*2 min(ElectronDensitySeries)*.5],'m','LineWidth',1.5)
    plot([MadData.TimeBound(2)-1 MadData.TimeBound(2)-1],...
        [max(ElectronDensitySeries)*2 min(ElectronDensitySeries)*.5],'m','LineWidth',1.5)
    xlabel('Time, min')
    ylabel('Electron Density, m^-^3')
    legend('Electron Density Measurements','Average Electron Density','Maximum Deviation due to the Soliton','Debris Observation Window')
    xlim([M_Time(1) M_Time(end)])
    ylim([min(ElectronDensitySeries)*.9 max(ElectronDensitySeries)*1.1 ])

    %plot electron density measurements deviation vs predicted electron
    %density deviation
    figure('DefaultAxesFontSize',14); hold on;
    plot([M_Time(1) M_Time(end)],[Umax-ElectronDensityAverage Umax-ElectronDensityAverage])
    plot(M_Time,abs(ElectronDensitySeries-ElectronDensityAverage))
    plot([MadData.TimeBound(1)+1 MadData.TimeBound(1)+1],...
        [max(ElectronDensitySeries)*2 min(ElectronDensitySeries)*.5],'m','LineWidth',1.5)
    plot([MadData.TimeBound(2)-1 MadData.TimeBound(2)-1],...
        [max(ElectronDensitySeries)*2 min(ElectronDensitySeries)*.5],'m','LineWidth',1.5)
    xlabel('Time, min')
    ylabel('Electron Density Standard Deviation, m^-^3')
    legend('Maximum Deviation due to the Soliton','Electron Density Measurement Deviation','Debris Observation Window')
    xlim([M_Time(1) M_Time(end)])
    ylim([0 max(abs(ElectronDensitySeries-ElectronDensityAverage))*1.1 ])

    %plot radar measurements
    figure('DefaultAxesFontSize',14)
    hold on
   
    colordata = colormap;
    colordata(1,:) = [1 1 1];
    clim([10^7 10^12]);
    colormap(colordata);
    imagesc(MadData.TimeNumDuration(1,:),MadData.Alt(:,1),MadData.UncorrectElectronDensity)%,Clim)
    set(gca,'ColorScale','log')
    set(gca,'YDir','normal')
    c = colorbar;
    c.Label.String = 'Raw Electron Density, m^-^3';
    xlabel('Time, min')
    ylabel('Altitude, km')
    xlim([min(MadData.TimeNumDuration(1,:)) max(MadData.TimeNumDuration(1,:))])
    ylim([min(MadData.Alt(:,1)) max(MadData.Alt(:,1))])
    [~, name, ~] = fileparts(file);
    formattedName = strrep(name, '_', ' ');
    formattedName = regexprep(formattedName, '(\<\w)', '${upper($1)}');
    title(formattedName)
    plot([MadData.TimeBound(1)+1 MadData.TimeBound(1)+1 MadData.TimeBound(2)-1 MadData.TimeBound(2)-1 MadData.TimeBound(1)+1],...
        [M_Alt(AltIndex-1) M_Alt(AltIndex+1) M_Alt(AltIndex+1) M_Alt(AltIndex-1)  M_Alt(AltIndex-1)],'m','LineWidth',1.5)
    legend('Debris Region')
end
% Original: Connor Wilson - Aug 2023
% Updated: Adrienne Rudolph - Jan 2024
%Filter Radar Data
close all
clear
clc

%Pick the associated target.mat file and madrigal file

%% Madrigal Jun 15, SpaceTrack Jun 14, 2010
%MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt'; file = 'CUBESAT XI-IV_2010_June_15_1';
%MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt'; file = 'CUBESAT XI-V_2010_June_15_2';
%MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt'; file = 'CUTE-1.7+APD II_2010_June_15_4';
MadFile = 'MAD6300_2010-06-15_tau7_60@42m.txt'; file = 'BEESAT_2010_June_15_5';

%% Madrigal May 11, SpaceTrack May 10, 2022
%MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';file = 'CP4_2022_May_11_1';
%MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';file ='SWISSCUBE_2022_May_11_1';
%MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';file = 'NANOSAT C BR1_2022_May_11_1';
%MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';file = 'AEROCUBE 6A_2022_May_11_1';
%MadFile = 'MAD6300_2022-05-11_tau7_60@42m.txt';file = 'YARILO-2_2022_May_11_1'; 

%% Madrigal May 28, SpaceTrack May 27, 2022
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'CANX-1_2022_December_28_1';
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'CUBESAT XI 4_2022_December_28_2';
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'GOMX 1_2022_December_28_3';
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'XW-2E_2022_December_28_4';
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'XW-2F_2022_December_28_5';
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'SMOG-1_2022_December_28_9';
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'SPACEBEE-117_2022_December_28_10';


%MadFile = 'MAD6300_2022-05-10_tau7_60@42m.txt';file = 'CSTB 1_2022_May_10_1'; %%10x10x10
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'CANX-1_2022_December_28_1'; %10x10x10
%MadFile = 'MAD6300_2022-12-28_tau7_60@42m.txt';file = 'CUBESAT XI 4_2022_December_28_1'; %10x10x10
%MadFile = 'MAD6300_2023-01-05_tau7_60@42m.txt';file = 'MAKERSAT 0_2023_January_05_1'; %10x10x10
%MadFile = 'MAD6300_2023-03-03_tau7_60@42m.txt';file = 'STRAND 1_2023_March_03_1'; %10x10x34

%MadFile = 'MAD6300_2023-09-01_tau7_60@42m.txt';file = 'SPACEBEENZ-16_2023_September_01_1';

%MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';file = 'AUBIESAT-1_2024_January_12_1';
%MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';file = 'ANDESITE_2024_January_12_1';
%MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';file = 'FLOCK 4S 1_2024_January_12_1';
%MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';file = 'FLOCK 4S 17_2024_January_12_1';
%MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';file = 'MOVE-II_2024_January_12_1'; %1U cubesat
%MadFile = 'MAD6300_2024-01-12_tau7_60@42m.txt';file = 'TEVEL 1_2024_January_12_1'; %1U cubesat

%MadFile = 'MAD6300_2024-01-16_tau7_60@42m.txt';file = 'QMR-KWT_2024_January_16_1'; %1U cubesat

%MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';file = 'PROMETHEUS 2-1_2024_January_18_1';
%MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';file = 'ESTCUBE1_2024_January_18_1';%dont use
%MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';file = 'KOSEN-1_2024_January_18_1';
%MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';file = 'MDASAT-1C_2024_January_18_1';
%MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';file = 'SNUGLITE-II_2024_January_18_1';
%MadFile = 'MAD6300_2024-01-18_tau7_60@42m.txt';file = 'SPACEBEE-160_2024_January_18_1';

%% --------------- No inputs past this point --------------- %%
load(['matFiles/' file '.mat'],'TargetStates','TargetUTC')          %load target.mat file
UTCrange = [TargetUTC(1) TargetUTC(end)];                           %Find the first and last propagation time
[MadData] = ReadMadrigalDataFunction(MadFile,UTCrange,false);       %process the radar data
M_Alt = MadData.Alt(:,1);                                           %Extract altitude
M_Time = MadData.TimeNumDuration(1,:);                              %Extract time
M_ElcDen = MadData.AdjustUncorrectElectronDensity;                  %Extract electron density measurement
%%
fprintf('Filtering Measurements\n')

%estimate the radar altitude nearest to the target at the start of the overfly
%and use those measurements for filtering
CurrentPos = TargetStates(1,1:3);
CurrentLLA = ecef2lla(CurrentPos); 
[~,NearestAlt] = min(abs(M_Alt-CurrentLLA(3)/1000)); 
m = M_ElcDen(NearestAlt,:);
[timeM,mUsed,mEst,tCorrelation] = FilterData(m,M_Time);

%%
%plotting section
figure
hold on
plot(timeM,mUsed)
plot(timeM,mEst)
plot([MadData.TimeBoundExtra(1)+1 MadData.TimeBoundExtra(1)+1],...
    [0 10^12],'m','LineWidth',1.5)
xregion(tCorrelation(:,1),tCorrelation(:,2));
plot([MadData.TimeBoundExtra(2)-1 MadData.TimeBoundExtra(2)-1],...
    [0 10^12],'m','LineWidth',1.5)
axis([-inf,inf,0,max(mUsed)*1.2])
xlabel('Time (min)')
ylabel('Electron Density')
[~, name, ~] = fileparts(file);
formattedName = strrep(name, '_', ' ');
formattedName = regexprep(formattedName, '(\<\w)', '${upper($1)}');
title(formattedName)
legend('Measurement','Filtered Average','Target Overfly','Correlated Measurements')


%linear kalman filter
function [timeM,mUsed,m,tCorrelation] = FilterData(meas,M_Time)
%initialize starting values
Q = .1;     %expected process noise mean
R = 20;     %expected measurement noise mean
m0 = 0;     %initial mean value
P0 = 100;   %initial covariance
H = 1;      %measurement model matrix
A = 1;      %state transition matrix of dynamic model
KplusCount = 0;

%filter measurements
for k = 1:length(meas)
    if k > 1
        %blank bad measurements (negative values) and skip them
        if meas(k+KplusCount) < 0
            while meas(k+KplusCount) < 0
                KplusCount = KplusCount + 1;
                if k+KplusCount >= length(meas)
                    mUsed(k) = meas(k+KplusCount-2);
                    timeM(k) = M_Time(k+KplusCount-2);
                    break
                end
                mUsed(k) = meas(k+KplusCount);
                timeM(k) = M_Time(k+KplusCount);
            end
        else
            mUsed(k) = meas(k+KplusCount);
            timeM(k) = M_Time(k+KplusCount);
        end
        %filter prediction
        m(:,k) = A*m(:,k-1);
        P(k) = A*P(k-1)*A'+ Q;
        %filter update
        v = mUsed(k)-H*m(:,k);
        S = H*P(k)*H'+ R;
        K = P(k)*H'*inv(S);
        m(:,k) = m(:,k) + K*v;
        P(k) = P(k) - K*S*K';
    else
        %intialize the filter
        mUsed(1) = meas(k);
        v = mUsed(1)-H*m0;
        S = H*P0*H'+ R;
        K = P0*H'*inv(S);
        m(:,k) = m0 + K*v;
        P(k) = P0 - K*S*K';
    end
    %exit if counting past the total number of measurements
    if k+KplusCount >= length(meas)
        break
    end
end

%setup correlation test - this will look for 4 consecutive estimate increases 
mTest = (m - [0 m(1:end-1)])>0; %check for positive increases from one update to the next
ii = 0;
i = 0;
tCorrelation = [];
while i < length(mTest)-3
    i = i + 1;
    if mTest(i) > 0
        if mTest(i+1) > 0
            if mTest(i+2) > 0
                if mTest(i+3) > 0
                    if mTest(i+4) > 0
                        if mTest(i+5) > 0
                        ii = ii + 1;
                        mCorrelation(i:i+5) = 1;
                        tCorrelation(ii,:) = [timeM(i-1) timeM(i+4)];
                        i = i + 4;
                        else
                        ii = ii + 1;
                        mCorrelation(i:i+4) = 1;
                        tCorrelation(ii,:) = [timeM(i-1) timeM(i+3)];
                        i = i + 4;
                        end
                    else
                    ii = ii + 1;
                  mCorrelation(i:i+3) = 1;
                  tCorrelation(ii,:) = [timeM(i-1) timeM(i+2)];
                  i = i + 3;
                    end
                end
            end
        end
    end
end
end
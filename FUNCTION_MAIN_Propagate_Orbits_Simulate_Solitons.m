
% Connor Wilson - August 2023
%function propagate_orbital_debris
% Updated by Adrienne Rudolph
% 02/25/2024
close all
clear
clc

%select the target and the xls file (the most recent set of detections from
%before the overfly; this could be on the day before the overfly or the day of it)
%target_selected = 'all'; fileName = 'SpaceDebris18Nov2018.xlsx'; %10x10x10 cm on 10th %all targets on the 10th

%target_selected = 'all';fileName = 'SpaceDebris14Jun2010.xlsx';


%% Madrigal June 15, SpaceTrack June 14, 2010
%target_selected = 'CUBESAT XI-IV'; fileName = 'SpaceDebris14Jun2010.xlsx'; %1U
%target_selected = 'CUBESAT XI-V'; fileName = 'SpaceDebris14Jun2010.xlsx'; %1U
%target_selected = 'CUTE-1.7+APD II'; fileName = 'SpaceDebris14Jun2010.xlsx'; %2U
%target_selected = 'BEESAT'; fileName ='SpaceDebris14Jun2010.xlsx'; %1U

%% Madrigal May 11, SpaceTrack May 10
%target_selected = 'CP4'; fileName = 'SpaceDebris10May2022.xlsx'; %1U
%target_selected = 'CANX-2'; fileName = 'SpaceDebris10May2022.xlsx'; %3U
%target_selected = 'SWISSCUBE'; fileName = 'SpaceDebris10May2022.xlsx'; %1U
%target_selected = 'NANOSAT C BR1'; fileName ='SpaceDebris10May2022.xlsx'; %1U
%target_selected = 'FLOCK 1C 1'; fileName = 'SpaceDebris10May2022.xlsx'; %3U
%target_selected = 'FLOCK 1C 6'; fileName = 'SpaceDebris10May2022.xlsx'; %3U
%target_selected = 'AEROCUBE 6A'; fileName ='SpaceDebris10May2022.xlsx';%0.5U
%target_selected = 'EXOCUBE'; fileName = 'SpaceDebris10May2022.xlsx'; %3U
%target_selected = 'LEMUR 2 GREGROBINSON'; fileName ='SpaceDebris10May2022.xlsx'; %3U
%target_selected = 'LEMUR 2 YNDRD'; fileName = 'SpaceDebris10May2022.xlsx'; %3U
%target_selected = 'YARILO-2'; fileName = 'SpaceDebris10May2022.xlsx'; %1.5U
%target_selected = 'NETSAT-4'; fileName = 'SpaceDebris10May2022.xlsx';%3U

%% Madrigal Dec 28, SpaceTrack Dec 27
%target_selected = 'CANX-1'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U
%target_selected = 'CUBESAT XI 4'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U
%target_selected = 'GOMX 1'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U
%target_selected = 'XW-2E'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U
%target_selected = 'XW-2F'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U
%target_selected = 'SUCHAI'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U
%target_selected = 'SMOG-1'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U
%target_selected = 'SPACEBEE-117'; fileName = 'SpaceDebris27Dec2022.xlsx'; %1U

%% Madrigal 17 Jan, SpaceTrack 16 Jan
%target_selected = 'QMR-KWT'; fileName = 'SpaceDebris16Jan2024.xlsx'; % 1U

%% Madrigal 19 Jan, SpaceTrack 18 Jan, 2022
%target_selected = 'PROMETHEUS 2-1'; fileName = 'SpaceDebris18Jan2024.xlsx'; % 1.5U
%%%target_selected = 'M-CUBED/EXP-1 PRIME'; fileName='SpaceDebris18Jan2024.xlsx'; % 1U - cannot use because of name
%%%target_selected = 'ESTCUBE 1'; fileName = 'SpaceDebris18Jan2024.xlsx'; %1U
%target_selected = 'KOSEN-1'; fileName = 'SpaceDebris18Jan2024.xlsx'; %2U
%target_selected = 'MDASAT-1C'; fileName = 'SpaceDebris18Jan2024.xlsx'; %2U
%target_selected = 'SNUGLITE-II'; fileName = 'SpaceDebris18Jan2024.xlsx';%2U
%target_selected = 'SPACEBEE-160'; fileName ='SpaceDebris18Jan2024.xlsx';%0.25U

%% Madrigal 13 Jan, SpaceTrack 12 Jan, 2024
%target_selected = 'MOVE-II'; fileName = 'SpaceDebris12Jan2024.xlsx'; % 1U
%target_selected = 'TEVEL 1'; fileName = 'SpaceDebris12Jan2024.xlsx'; % 1U
%target_selected = 'ANDESITE'; fileName = 'SpaceDebris12Jan2024.xlsx';
%target_selected = 'FLOCK 4S 17'; fileName = 'SpaceDebris12Jan2024.xlsx';
%target_selected = 'FLOCK 4S 1'; fileName = 'SpaceDebris12Jan2024.xlsx';
%target_selected = 'AUBIESAT-1'; fileName = 'SpaceDebris12Jan2024.xlsx';
%target_selected = 'TEVEL 1'; fileName = 'SpaceDebris12Jan2024.xlsx';

%% Madrigal 2 Mar, SpacceTrack 01 Sept, 2023
%target_selected = 'SPACEBEENZ-16'; fileName = 'SpaceDebris01Sept2023.xlsx';

%% Conner's Collection -----
target_selected = 'CSTB 1'; fileName = 'SpaceDebris09May2022.xlsx'; %10x10x10 cm on 10th
%target_selected = 'CP4'; fileName = 'SpaceDebris10May2022.xlsx'; %10x10x10 cm on 11th
%target_selected = 'CANX-1'; fileName = 'SpaceDebris27Dec2022.xlsx'; %10x10x10 cm on 28th
%target_selected = 'CUBESAT XI 4'; fileName = 'SpaceDebris27Dec2022.xlsx'; %10x10x10 cm on 28th
%target_selected = 'GOMX 1'; fileName = 'SpaceDebris27Dec2022.xlsx'; %10x10x20 cm on 28th
%target_selected = 'MAKERSAT 0'; fileName = 'SpaceDebris05Jan2023.xlsx'; %10x10x2010 cm on 5th
%target_selected = 'STRAND 1'; fileName = 'SpaceDebris02Mar2023.xlsx'; %10x10x34 cm on 3rd
%% ----------

%set the start time of the radar data and the end time of the radar data
%dateRadarStartTime = datetime(2007,12,15,12,7,3,'timezone','UTC'); dateRadarEndTime = datetime(2007,12,15,18,58,11,'timezone','UTC');
%dateRadarStartTime = datetime(2010,6,15,7,51,33,'timezone','UTC'); dateRadarEndTime = datetime(2010,6,15,23,59,30,'timezone','UTC');
%dateRadarStartTime = datetime(2018,11,19,20,1,30,'timezone','UTC'); dateRadarEndTime = datetime(2018,11,19,23,59,3 ...
%    ,'timezone','UTC');
dateRadarStartTime = datetime(2022,5,10,0,30,0,'timezone','UTC'); dateRadarEndTime = datetime(2022,5,10,5,0,0,'timezone','UTC');
%dateRadarStartTime = datetime(2022,5,11,0,30,0,'timezone','UTC'); dateRadarEndTime = datetime(2022,5,11,5,0,0,'timezone','UTC');
%dateRadarStartTime = datetime(2022,12,28,6,0,36,'timezone','UTC'); dateRadarEndTime = datetime(2022,12,28,9,59,30,'timezone','UTC');
%dateRadarStartTime = datetime(2023,1,5,18,0,30,'timezone','UTC'); dateRadarEndTime = datetime(2023,1,5,23,59,6,'timezone','UTC');
%dateRadarStartTime = datetime(2023,3,3,19,4,42,'timezone','UTC'); dateRadarEndTime = datetime(2023,3,3,20,54,27,'timezone','UTC');
%dateRadarStartTime = datetime(2023,9,1,12,5,53,'timezone','UTC'); dateRadarEndTime = datetime(2023,9,1,12,42,14,'timezone','UTC');
%dateRadarStartTime = datetime(2024,1,12,15,1,33,'timezone','UTC'); dateRadarEndTime = datetime(2024,1,12,18,59,30,'timezone','UTC');
%dateRadarStartTime = datetime(2024,1,16,15,0,33,'timezone','UTC'); dateRadarEndTime = datetime(2024,1,16,16,47,9,'timezone','UTC');
%dateRadarStartTime = datetime(2024,1,18,15,0,33,'timezone','UTC'); dateRadarEndTime = datetime(2024,1,18,18,59,30,'timezone','UTC');

%select a radar set, adjust the azimuth, elevation, max altitude, and beam
%width angle as needed from the dataset
radar_selected = 'Svalbard (Longyearbyen)';
radarChar.azm = 184.5; %azmith (0 = north, 90 = east)
radarChar.elm = 81.60; %elevation ( 90 = vertical, 0 = horizontal)
radarChar.MaxAlt = 1350; %maximum altitude of the radar beam (km)
radarChar.beamAngle = 5; %beam width angle (degree) - estimated from EISCAT documentation

%set constants
DebrisDiameter = 0.1;   %debris diameter for soliton prediction (meters) --> TURN INTO RADIUS?
MinApogee = 400;        %minimum target apogee (kilometers) - WOULD THIS NOT BE PERIGEE?
limitTargets = true;    %sort the targets to only look at potentially viable targets
plotIt = true;           %plot overfly, radar, and Earth
ForceLoad = true ;      %force a reprocessing of the space-track data

%% --------------- No inputs past this point --------------- %%
%set paths

addpath(genpath('/Users/arudy/Documents/Adrienne/UMD/Research/Conner_Research/ThesisSoftwareWilson/Scripts'))
%path_debris = ['/Users/wilson/Documents/Work/ThesisSoftwareWilson/Data/SpaceTrack/' fileName];
path_debris = ['/Users/arudy/Documents/Adrienne/UMD/Research/Conner_Research/ThesisSoftwareWilson/Data/SpaceTrack/' fileName];
%path_radar = '/Users/wilson/Documents/Work/ThesisSoftwareWilson/Data/Radar_Selection_Trade_Study.xlsx';
path_radar = '/Users/arudy/Documents/Adrienne/UMD/Research/Conner_Research/ThesisSoftwareWilson/Data/Radar_Selection_Trade_Study.xlsx';
%set max trajectory processing size based on the length of the experiment
WindowMaxSize = seconds(dateRadarEndTime-dateRadarStartTime);

%select date for save files
DateToWrite = [datestr(dateRadarEndTime,'yyyy') '_' datestr(dateRadarEndTime,'mmmm') '_' datestr(dateRadarEndTime,'dd')];


%if the target data was already processed, do not reprocess the data.
if exist(['matFiles/targets_of_opportunity_' DateToWrite '.mat'],'file') && ~ForceLoad
    fprintf('Loading pre-processed target file for debris data...\n')
    load(['matFiles/targets_of_opportunity_' DateToWrite '.mat'])
else
    fprintf('Processing target file for debris data...\n')
    targets_of_opportunity = find_orbital_debris(path_debris,limitTargets,MinApogee);
    save(['matFiles/targets_of_opportunity_' DateToWrite '.mat'],'targets_of_opportunity')
end

%emplace all the radars in ECEF coordinates
[radar_ecef,radar_name] = generate_radar_emplacements(path_radar);
radar_name = [{'Earth'};radar_name];
radar_ecef = [0 0 0; radar_ecef];


fprintf('Generating orbits...\n')
%Orbital Elements
e = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'eccentricity')));
i = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'inclination')));
cap_omega = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'right ascension of ascending node')));
omega = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'argument of pericenter')));
M = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'mean anomaly')));
n = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'mean motion')));
bstar = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'BSTAR')));
ndot = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'mean motion dt')));
nddot = cell2mat(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'mean motion ddt')));
epoch = datetime(targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'epoch')));
target_names = (targets_of_opportunity(2:end,strcmp(targets_of_opportunity(1,:),'object name')));

%%
%calculate propagation time
for ii = 2:length(targets_of_opportunity)     % loop over each target
    d1(ii-1) = datetime(targets_of_opportunity{ii,4},'TimeZone','UTC'); % date and time for current target
    d2(ii-1,:) = between(dateRadarEndTime, d1(ii-1),'Time'); % difference in time
end
timeHMS = time(d2);         %time in hours minutes seconds
t0 = 0;                     %Start time (sec)
tf = -seconds(timeHMS);     %Time to Propagate (sec)

%Start propagation - only propagate selected targets unless all targets selected.
l = 0;
for j = 1:length(e)
    if any(strcmp(target_selected,target_names(j))) || strcmp(target_selected,'all')
        l = l+1;
        [TempTargetPositionTime{l},TempUTCtime{l},TempAshape{l},StartTime{l}] = propagator(length(e),...
            j,n(j), e(j), i(j), cap_omega(j),omega(j), M(j),bstar(j),ndot(j),nddot(j),epoch(j),t0,tf(j),...
            targets_of_opportunity,target_names{j},radar_ecef(strcmp(radar_name,radar_selected),:),WindowMaxSize,radarChar);
        TrackName{l} = target_names{j};
    elseif j == length(e) && l == 0
        fprintf('no targets found\n')
        return
    end
end

%%

%select the trajectory that spends the most time in the radar beam
%this is dependent on the tracks all being one name at a time which they
%should be: a a a then b b b then c c c etc
%this looks for duplicate detections and removes them for the most recent
%detection in the past
UniqueTracks = "blank";
bb = 0;
for b = 1:length(TrackName)
    %select first track by name
    if ~any(strcmp(UniqueTracks,convertCharsToStrings(TrackName{b}))) && ~isnan(TempTargetPositionTime{b}(1))
        bb = bb + 1;
        UniqueTracks(bb) = convertCharsToStrings(TrackName{b});
        UniqueTrackIndex(bb) = b;
        UniqueTrackStartTime(bb) = StartTime{b};
    else %select better track duplicate if it spends more time in the radar beam
        if ~isnan(TempTargetPositionTime{b}(1)) && dateRadarStartTime > StartTime{b} && UniqueTrackStartTime(bb) < StartTime{b}
            UniqueTracks(bb) = convertCharsToStrings(TrackName{b});
            UniqueTrackIndex(bb) = b;
            UniqueTrackStartTime(bb) = StartTime{b};
        end
    end
end
%%
%save off best target
if exist('UniqueTrackIndex','var')
TargetPositionTime = TempTargetPositionTime(UniqueTrackIndex);
UTCtime = TempUTCtime(UniqueTrackIndex);
Ashape = TempAshape(UniqueTrackIndex);
ll = length(TargetPositionTime);

%soliton generation
for k = 1:ll
    %this function takes the first point passing through the radar beam and
    %uses it to generate the soliton. this is based on the assumption that the
    %background electron density is relatively constant over the course of a
    %minute.
    clear xDim yDim uDim tDim U TargetStates TargetUTC
    TargetStates = TargetPositionTime{k};
    TargetUTC = UTCtime{k};
    fprintf('Calculating Soliton... \n')
    time = TargetStates(:,7)-TargetStates(1,7);
    tic

    [~,~,~,~,~,xDim,yDim,uDim,~,~,tDim,U] = UpdateSoliton(TargetStates(1,1:3),TargetStates(1,4:6),TargetUTC(1),0,DebrisDiameter);
    t = toc;
    fprintf(['  processed ' UniqueTracks{k} ' - processing time is ' num2str(t/60) ' minutes \n'])

    save(['matFiles/' UniqueTracks{k} '_' DateToWrite '_' num2str(k) '.mat'], '-v7.3','TargetStates','tDim','U','xDim','yDim','TargetUTC')
end

%plot radar, Earth, and track
if plotIt
    plot_debris_orbits_with_radar(radar_ecef,TargetPositionTime,radar_name,Ashape,TrackName)
end
else
fprintf('No targets passed through the beam...\n')
end
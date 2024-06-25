% Connor Wilson - August 2023
function [MadData] = ReadMadrigalDataFunction(fileName,UTCrange,ShrinkTable)
%this function is the parser for the madrigal data set
%
%set margin for error in window estimation
WindowMargin = 5;

fprintf('Reading Madrigal Data\n')
%read raw table
MadRawTable = readtable(fileName);
%%
fprintf('Unpacking Madrigal Data\n')
MadTable = MadRawTable;
toDelete1 = MadTable.RANGE < 400;   %remove data below 400 km
MadTable(toDelete1,:) = [];
size(MadTable);
toDelete2 = MadTable.RGATE < 100;   %remove range gates that arent part of the target set
MadTable(toDelete2,:) = [];         %this is suspected to be something else that isnt relavent
size(MadTable);                     %to what we are looking for

%estimate the duration of the experiment in minutes
InitialTime = datetime(MadTable.YEAR,MadTable.MONTH,MadTable.DAY,MadTable.HOUR,MadTable.MIN,MadTable.SEC,'TimeZone','UTC');
InitialTimeNumDuration = minutes(InitialTime-InitialTime(1));

%%
%shrink table
if ShrinkTable
    %only look at the dataset near when the target is overhead
    fprintf('    Shrinking Madrigal Data\n')
    LowerTime = floor(minutes(UTCrange(1)-InitialTime(1)))-WindowMargin;
    UpperTime = ceil(minutes(UTCrange(2)-InitialTime(1)))+WindowMargin;
    TimeWindow = logical((InitialTimeNumDuration > LowerTime) + (InitialTimeNumDuration < UpperTime)-1);
    MadTableNew = MadTable(TimeWindow,:);
    Time = InitialTime(TimeWindow);
    TimeNumDuration = InitialTimeNumDuration(TimeWindow);
    TimeWindowLower = logical(InitialTimeNumDuration < LowerTime);
    TimeDurationLower = InitialTimeNumDuration(TimeWindowLower);
    LowerTime1 = floor(minutes(UTCrange(1)-InitialTime(1)))-WindowMargin;
    UpperTime2 = ceil(minutes(UTCrange(2)-InitialTime(1)))+WindowMargin;
else
    %dont reduce the size of the dataset
    LowerTime = InitialTime(1);
    UpperTime = InitialTime(end);
    LowerTime1 = floor(minutes(UTCrange(1)-InitialTime(1)))-WindowMargin;
    UpperTime2 = ceil(minutes(UTCrange(2)-InitialTime(1)))+WindowMargin;
    MadTableNew = MadTable;
    Time = InitialTime;
    TimeNumDuration = InitialTimeNumDuration;
    TimeDurationLower = 0;
end
%%
%extract the desired variables for the desired times
fprintf('    Processing Madrigal Data\n')
UniqueTimes = unique(TimeNumDuration);
UniqueTimesLower = unique(TimeDurationLower);
b = 1;
for k = max(1,length(UniqueTimesLower)):(length(UniqueTimes)+length(UniqueTimesLower))
clear Rows
Rows = MadTableNew.RECNO == k-1;
if any(Rows)
MadData.Range(:,b) = MadTableNew(Rows,:).RANGE;
MadData.AzimuthAngle(:,b)  = MadTableNew(Rows,:).AZM;
MadData.ElevationAngle(:,b)  = MadTableNew(Rows,:).ELM;
MadData.HalfScatterAngle(:,b)  = MadTableNew(Rows,:).HSA;
MadData.UncorrectElectronDensity(:,b)  = MadTableNew(Rows,:).POP;            %Te/Ti = 1, units m^3
MadData.UncorrectElectronDensityError(:,b)  = MadTableNew(Rows,:).DPOP;            %Te/Ti = 1, units m^3
MadData.RangeGateWidthKM(:,b)  = MadTableNew(Rows,:).RGATE;
MadData.Time(:,b) = Time(Rows,:);
MadData.TimeNumDuration(:,b) = TimeNumDuration(Rows,:);
b = b + 1;
end
end

%%
%adjust the data to all be the same altitude ranges if needed (this rarely
%does anything but occassionally a few measurements vary in altitude and
%will break the scripts
MadData.AdjustRange(:,1) = MadData.Range(:,1);  
for g = 2:length(MadData.Range(1,:))
    if ~(all(MadData.Range(:,1) == MadData.Range(:,g)))
        MadData.AdjustUncorrectElectronDensity(:,g) = interp1(MadData.Range(:,g),MadData.UncorrectElectronDensity(:,g),MadData.Range(:,1));
        MadData.AdjustUncorrectElectronDensityError(:,g) = interp1(MadData.Range(:,g),MadData.UncorrectElectronDensityError(:,g),MadData.Range(:,1));
        MadData.AdjustRange(:,g) = MadData.Range(:,1);    
    end
end

%change range to altitude
MadData.Alt = MadData.AdjustRange.*sind(MadData.ElevationAngle);
%dont extract azimuth and elevations because they are constant and used by
%the prior script
%AZM: Mean azimuth angle (0=geog N;90=east), units: deg
%ELM: Elevation angle (0=horizontal;90=vert), units: deg
%identify time regions of interest with bounds
MadData.TimeBound = [LowerTime+WindowMargin UpperTime-WindowMargin];
MadData.TimeBoundExtra = [LowerTime1+WindowMargin UpperTime2-WindowMargin];
end
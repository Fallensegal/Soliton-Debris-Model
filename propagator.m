% Connor Wilson - August 2023
function [TargetPositionTime,UTCwindow,Ashape,StartTime] = xyz_propagator(maxT,j,n, e, i, cap_omega, omega, M,bstar,ndot,nddot,epoch,t0,tf,target,target_names,radar_ecef,WindowMaxSize,radarChar)

fprintf(['      processing debris ' num2str(j) ' of ' num2str(maxT) '\n'])
fprintf('          propagating SGP4 ECI trajectory... \n')
%propagate orbit
[r_eci,v_eci,t] = XYZ_SGP4_Debris_Orbit(t0,tf,e, i, cap_omega, omega, M, n,bstar,ndot,nddot,epoch);
UTCtime = datetime(target{j+1,4},'TimeZone','UTC') + seconds(t); % adjustment to date time for each step
StartTime = UTCtime(1);         %save the detection time for later reference
UTCtimeNum = datenum(UTCtime);  %set date it number format

%estimate how much to reduce the size of the trajectory to be only the lange of the window
fprintf('          shortening look window... \n')
window = WindowMaxSize;
if window > length(UTCtime) %target exists for the entire length of the experiment
    UTCwindowShort = UTCtime;
    UTCnumWindowShort = UTCtimeNum;
else                        %the target was detected part way through the experiment
    UTCwindowShort = UTCtime(end-(window-1):end,:);
    UTCnumWindowShort = UTCtimeNum(end-(window-1):end,:);
    %this could be removed if backwards propagation was also implemented
    %instead of just forward propagation
end

%reduce the length of the trajecotry
for k = 1:length(UTCwindowShort)
    timeShort(k,:) = t(k+(length(UTCtime)-length(UTCwindowShort)),:);
    r_eci_short(k,:) = r_eci(k+(length(UTCtime)-length(UTCwindowShort)),:)';
    v_eci_short(k,:) = v_eci(k+(length(UTCtime)-length(UTCwindowShort)),:)';
end

%convert from ECI to ECEF to align position of target and radar
fprintf('          transforming from ECI to ECEF... \n')
parfor kk = 1:length(timeShort)
    [r_ecef(kk,:),v_ecef(kk,:)] = eci2ecef(UTCwindowShort(kk),r_eci_short(kk,:)'*1000,v_eci_short(kk,:)'*1000);
end

%calculate the convex hull/alpha shape and estimate when the target is in
%the beam if at all
[WindowCell,WindowRange,Ashape] = GetLookWindow([r_ecef,v_ecef,timeShort,UTCnumWindowShort],radar_ecef,radarChar);

%populate the window with a nan if the debris didnt pass over the radar
if isnan(WindowCell(1))
    TargetPositionTime = nan;
    UTCwindow = nan;
    Ashape = nan;
    fprintf('          debris was not observed... \n')
    return
end

%save outputs
time = WindowCell(:,7);
R = WindowCell(:,1:3);
V = WindowCell(:,4:6);
UTCwindow = UTCwindowShort(WindowRange(1):WindowRange(2),:);
UTCnumWindow = UTCnumWindowShort(WindowRange(1):WindowRange(2),:);
LLA = ecef2lla(R);
TargetPositionTime = [R,V,time,UTCnumWindow];
fprintf(['          The target, ' target_names ', started at '  num2str(LLA(1,1))  ' lat, ' num2str(LLA(1,2))  ' lon, and ' num2str(LLA(1,3)/1000)  ' km alt at ' datestr(UTCtime(1)) ' \n'])
fprintf(['          The target, ' target_names ', is at '  num2str(LLA(end,1))  ' lat, ' num2str(LLA(end,2))  ' lon, and ' num2str(LLA(end,3)/1000)  ' km alt at ' datestr(UTCtime(end)) ' \n'])
end
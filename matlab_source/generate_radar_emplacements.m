% Connor Wilson - August 2023
function [radar_ecef, radar_name] = generate_radar_emplacements(path)
%this function emplaces the preselected radars
%if you want to add more radars some work will be required as this is
%based on a brief trade study on the EISCAT radars
%You can add additional radars to the trade study 
%you should only require the name, altitude (meters), latitude (degrees,
%minutes, seconds), and longitude(degrees, minutes, seconds). All other
%information can be left blank unless the software throws an error reading
%it

fprintf('Emplacing Radars...\n')

%read radar information
[~,~,radar_data_array] = xlsread(path);
radars = column_sort(radar_data_array,'Frequency Band','HF',0);

%extract altitude, latitude, and longitude
radars_alt = cell2mat(radars(2:length(radars(:,1)),strcmp(radars(1,:),'Altitude (m)')));
radars_lat_unform = radars(2:length(radars(:,1)),strcmp(radars(1,:),'Latitude'));
radars_lon_unform = radars(2:length(radars(:,1)),strcmp(radars(1,:),'Longitude'));

%convert DMS to degrees
[radars_lat] = expand_DMS_from_Lat_or_lon(radars_lat_unform);
[radars_lon] = expand_DMS_from_Lat_or_lon(radars_lon_unform);
%form radar position vector (degrees, degrees, meters)
radar_pos = [radars_lat radars_lon radars_alt];
j = 1;
%sort the trade study to avoid duplicate radars - this looks complicated
%but it is a simple sort and converts lat-lon-alt to
%Earth-Centered-Earth-Fixed coordinates in kilometers
for i = 1:length(radar_pos(:,1))
    if i == 1
        %take the first case to start the list
        radar_ecef(j,:) = lla2ecef(radar_pos(i,:), 'WGS84')./1000;
        radar_name(j,:) = radars(i+1,strcmp(radars(1,:),'Radar Site'));
        fprintf(['      The radar, ' radar_name{j,:} ', is emplaced at '...
            num2str(radar_pos(i,1))  ' lat, ' num2str(radar_pos(i,2)) ...
            ' lon, and ' num2str(radar_pos(i,3)/1000)  ' km alt \n'])
        j = j + 1;
    elseif any(radar_pos(i,1) ~= radar_pos(1:i-1,1)) || any(radar_pos(i,2) ~= radar_pos(1:i-1,2))...
            || any(radar_pos(i,3) ~= radar_pos(1:i-1,3))
        %sort all other cases based on whether there is a duplicate or not
        radar_ecef(j,:) = lla2ecef(radar_pos(i,:), 'WGS84')./1000;
        radar_name(j,:) = radars(i+1,strcmp(radars(1,:),'Radar Site'));
        fprintf(['      The radar, ' radar_name{j,:} ', is emplaced at '...
            num2str(radar_pos(i,1))  ' lat, ' num2str(radar_pos(i,2)) ...
            ' lon, and ' num2str(radar_pos(i,3)/1000)  ' km alt \n'])
        j = j + 1;
    end
end

end

function [degrees] = expand_DMS_from_Lat_or_lon(unformatted)
%convert Lat and Lon DMS to Lat and Lon degrees for each radar
for i = 1:length(unformatted)
    current_lla = unformatted{i};

    degrees = str2double(current_lla(1:2));
    minutes = str2double(current_lla(4:5));
    seconds = str2double(current_lla(7:8));

    DMS(i,1) = degrees;
    DMS(i,2) = minutes;
    DMS(i,3) = seconds;
end
degrees = dms2degrees(DMS);
end
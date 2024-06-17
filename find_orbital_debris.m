% Connor Wilson - August 2023
function targets_of_opportunity = find_orbital_debris(path_debris,selectTargets,MinApogee)
%this function will sort the targets for small RCS (likely CubeSats, small
%satellites or debris), payload type (removes debris), high inclination
%(high enough to be seen by 
RCS = 'SMALL';
OldestDate = datetime(2000,01,01);
ObjTyp = 'PAYLOAD';

%read the xlm (xlsx) file. This needs to be saved as an xlsx prior to
%running because sorting real xml files in matlab is convoluted compared to
%saving it as an xlsx file prior to running.
xmlFile = read_radar_track_xml(path_debris);

%sort the file to remove any targets with RCS of large, medium, or unkown
if selectTargets == true

    targets = column_sort(xmlFile,'OBJECT_TYPE',ObjTyp,1);
    low_rcs_targets = column_sort(targets,'RCS_SIZE',RCS,1);

    %sort the file to remove any targets with an absolute inclination less than 
    %60 degrees. These targets are not going to viewable by any of the radars 
    %that could be selected. Note: this includes removing targets with an
    %inclination greater than 120 degrees as well. aAso remove targets from 
    %before 2000 because CubeSats didnt exist before 2003 and remove low
    %apogee targets
    k_sort = 0;
    i_sort = cell2mat(low_rcs_targets(2:end,strcmp(low_rcs_targets(1,:),'inclination')));
    time_sort = low_rcs_targets(2:end,strcmp(low_rcs_targets(1,:),'LAUNCH_DATE'));
    Apoapsis = low_rcs_targets(2:end,strcmp(low_rcs_targets(1,:),'APOAPSIS'));
    for j_sort = 1:length(i_sort)
        if i_sort(j_sort) > 60 &&  i_sort(j_sort) < 120 && time_sort{j_sort} > OldestDate && Apoapsis{j_sort} > MinApogee
            k_sort = k_sort + 1;
            low_rcs_hi_inclination_recent_targets(k_sort,:) = low_rcs_targets(j_sort+1,:);
        end
    end
        %these are the low rcs targets that the radars may be able to see
        targets_of_opportunity = [low_rcs_targets(1,:); low_rcs_hi_inclination_recent_targets];
    else
    %use all targets instead of sorting
    targets_of_opportunity = xmlFile;
end
end
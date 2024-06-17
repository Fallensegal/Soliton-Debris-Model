# Orbit Propagator Code Analysis

## Issues Seen:

1. Hardcoding of Data Variables - `final_orbital_debris.m | line 6`

```matlab
function targets_of_opportunity = find_orbital_debris(path_debris,selectTargets,MinApogee)
%this function will sort the targets for small RCS (likely CubeSats, small
%satellites or debris), payload type (removes debris), high inclination
%(high enough to be seen by 
RCS = 'SMALL';
OldestDate = datetime(2000,01,01);
ObjTyp = 'PAYLOAD';
```

2. Deep Coupling

filename --> excel
passed to find orbital debris
<br>
passed to read_radar_track

hardcoding of space track data structure headers

```matlab
parameter_names = string({'spacetrack ID','argument of pericenter','eccentricity','epoch',...
    'inclination','mean anomaly','mean motion','right ascension of ascending node',...
    'BSTAR','mean motion ddt','mean motion dt','NORAD catalog ID','revolution number at epoch',...
    'mean element theory','object ID','object name','reference frame','time system','creation date'});
```


3. Inefficient Operations

code performing multiple string operations on data structures, using XML file where JSON is the prefered format since it has native libraries.

```matlab
fprintf('Extracting user defined values and reducing array size ...\n')
variables = convertCharsToStrings(text(2,:));

%this parses the dataset to identify specific values
[variable_index, variable_names] = select_radar_parameters(variables);

%extract the user defined parameters
new_variables = text(3:14,variables(1,:) == '/omm/body/segment/data/userDefinedParameters/USER_DEFINED/@parameter')';
new_variables = convertCharsToStrings(new_variables);
userdefined_values = raw(3:length(raw(:,1)),variables(1,:) == '/omm/body/segment/data/userDefinedParameters/USER_DEFINED')';

%add back the numerical time values
raw(3:length(raw(:,1)),strcmp(raw(2,:),'/omm/body/segment/data/meanElements/EPOCH')) = rawTimes(:,variables(1,:) == '/omm/body/segment/data/meanElements/EPOCH');
raw(3:length(raw(:,1)),strcmp(raw(2,:),'/omm/header/CREATION_DATE')) = rawTimes(:,variables(1,:) == '/omm/header/CREATION_DATE'); 
```

There are functions defined as part of string manipulation that are extremely expensive as they are iterating over large matrices of strings and performing calculations:

```matlab
%% Line 66 - Function definition (read_radar_track_xml.m)
function [parameter_index, parameter_names] = select_radar_parameters(raw_parameters)
```
% Connor Wilson - August 2023
function xmlOutput = read_radar_track_xml(path)
%this function reads the debris data file and sorts the variables that are
%available. Some of them are stored in column format and others are stored
%in row format. All the sorting and removal of unnecessary variables is
%handled by this function.

%ignore the warning for this table read. it is not an issue.
warning('off','MATLAB:table:ModifiedAndSavedVarnames') 

fprintf('Reading XML (XLSX) file for times...\n')
rawTimes = table2cell(readtable(path));

%re-enable the warning
warning('on','MATLAB:table:ModifiedAndSavedVarnames')

fprintf('Reading XML (XLSX) file for debris data...\n')
[~,text,raw] = xlsread(path);

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

j = 1;
k = 1;
for i = 1:length(userdefined_values)
    if j > 12
        j = 1;
        k = k + 1;
    end
        extracted_user_values(k,j) = userdefined_values(i);
        
    if j == 1
        extract_agg_value_text(k,:) = raw(i+2,:);
    end
        j = j + 1;
end

%convert times to cells so that they can be output in the array
times2convert = cell2mat(extracted_user_values(:,strcmp(new_variables,'LAUNCH_DATE')));
timesConverted = x2mdate(times2convert,0,'datetime');
extracted_user_values(:,strcmp(new_variables,'LAUNCH_DATE')) = mat2cell(timesConverted,ones(length(timesConverted),1),1);

%add headers to the output and store it all together
OrbitalData = [extract_agg_value_text(:,variable_index) extracted_user_values];
OrbitalDataHeader = cellstr([variable_names new_variables]);
xmlOutput = [OrbitalDataHeader;OrbitalData];
end






function [parameter_index, parameter_names] = select_radar_parameters(raw_parameters)
%this is the target parser function that parses the data file
parameter_index = [];

%{  
PARAMETER LIST
1  - spacetrack ID              2  - argument of pericenter
3  - eccentricity               4  - epoch
5  - inclination                6  - mean anomaly
7  - mean motion                8  - right ascesion of ascending node
9  - BSTAR                      10 - mean motion ddt
11 - mean motion dt             12 - NORAD catalog ID
13 - revolution number at epoch 14 - mean element theory
15 - object ID                  16 - object name
17 - reference frame            18 - time system
19 - creation date
%}

%scan over the parameters and find which columns they are in.
for i = 1:length(raw_parameters)
    
    paraTest = raw_parameters(i); %select the next parameters

switch paraTest
    case  '/omm/#id'
    % This is spacetrack ID
    parameter_index(1) = i;
    
    case '/omm/body/segment/data/meanElements/ARG_OF_PERICENTER/#agg'
    % This is argument of pericenter
    parameter_index(2) = i;
    
    case '/omm/body/segment/data/meanElements/ECCENTRICITY/#agg'
    % This is eccentricity
    parameter_index(3) = i;
    
    case '/omm/body/segment/data/meanElements/EPOCH'
    % This is epoch
    parameter_index(4) = i;
    
    case '/omm/body/segment/data/meanElements/INCLINATION/#agg'
    % This is inclination
    parameter_index(5) = i;
    
    case '/omm/body/segment/data/meanElements/MEAN_ANOMALY/#agg'
    % This is mean anomaly
    parameter_index(6) = i;
    
    case '/omm/body/segment/data/meanElements/MEAN_MOTION/#agg'
    % This is mean motion
    parameter_index(7) = i;
    
    case '/omm/body/segment/data/meanElements/RA_OF_ASC_NODE/#agg'
    % This is right ascesion of ascending node
    parameter_index(8) = i;
    
    case '/omm/body/segment/data/tleParameters/BSTAR/#agg'
    % This is BSTAR
    parameter_index(9) = i;
    
    case '/omm/body/segment/data/tleParameters/MEAN_MOTION_DDOT/#agg'
    % This is mean motion ddt
    parameter_index(10) = i;
    
    case '/omm/body/segment/data/tleParameters/MEAN_MOTION_DOT/#agg'
    % This is mean motion dt
    parameter_index(11) = i;
    
    case '/omm/body/segment/data/tleParameters/NORAD_CAT_ID/#agg'
    % This is NORAD catalog ID
    parameter_index(12) = i;
    
    case '/omm/body/segment/data/tleParameters/REV_AT_EPOCH/#agg'
    % This is revolutions at epoch
    parameter_index(13) = i;
    
    case '/omm/body/segment/metadata/MEAN_ELEMENT_THEORY'
    % This is mean element theory
    parameter_index(14) = i;
    
    case '/omm/body/segment/metadata/OBJECT_ID'
    % This is object ID
    parameter_index(15) = i;
    
    case '/omm/body/segment/metadata/OBJECT_NAME'
    % This is object name
    parameter_index(16) = i;
    
    case '/omm/body/segment/metadata/REF_FRAME'
    % This is reference frame
    parameter_index(17) = i;
    
    case '/omm/body/segment/metadata/TIME_SYSTEM'
    % This is time system
    parameter_index(18) = i;
    
    case '/omm/header/CREATION_DATE'
    % This is creation date
    parameter_index(19) = i;
end    
end

parameter_names = string({'spacetrack ID','argument of pericenter','eccentricity','epoch',...
    'inclination','mean anomaly','mean motion','right ascension of ascending node',...
    'BSTAR','mean motion ddt','mean motion dt','NORAD catalog ID','revolution number at epoch',...
    'mean element theory','object ID','object name','reference frame','time system','creation date'}); %#ok<STRCLQT>
end
% Connor Wilson - August 2023
function [sorted_array] = column_sort(array,column,value,find_Value)
%this function sorts the columns of arrays for desired variable and then
%selects the rows of that variable that contain the desired value or string
if find_Value
    sorted_array = [array(1,:); array(strcmp(array(:,strcmp(array(1,:),column)),value),:)];
else
    sorted_array = array(~strcmp(array(:,strcmp(array(1,:),column)),value),:);
end
end

% Wasif - This file is used to query row on excel file only used in hardcoding the specific radar in use
% Connor Wilson - August 2023s
function [Window,WindowRange,Ashape] = GetLookWindow(TargetPositionTime,radar_ecef,radarChar)
%this function will take the times of overfly and propagation that the time
%that spent the most time in the beam. 

%This function alligns the target with the beam with a boolean vector, tf
[tf,Ashape] = OverflyTimeFunction(TargetPositionTime,radar_ecef,radarChar);

%if any time is returned then the target passed through the radar beam
if any(tf)
fprintf('       Target Overhead of Radar\n')
end

j = 1;
k = 1;
h = 1;
BestWindow = 0;
%this will shorten the window in which the target overflew the radar and if
%the target was detected more than once, then this will select the best
%overfly window
for i = 1:length(tf)-1

    if tf(i)    %if the target was overhead of the radar
        %build the window of time that the target is ovehead of the rdaar
        TempIndex(k) = i;
        temp(k,:) = TargetPositionTime(i,:);
        k = k + 1;
        if ~tf(i+1) %if the target will not be overhead of the radar next update
                %end the overfly window
                AllWindow{h} = temp;
                AllWindowIndex{h} = TempIndex;
                h = h + 1;
            if length(BestWindow) < length(temp(:,1)) %check to see if this window was better than other windows
                clear BestWindow BestWindowIndex
                BestWindow = temp;
                BestwindowIndex = TempIndex;
                j = j + 1;
            end
            k = 1;
            clear temp TempIndex
        end
    end
end

%if there is a window then save it and otherwise return nan
if length(BestWindow) > 2
Window = TargetPositionTime(BestwindowIndex(1)-60:BestwindowIndex(end)+60,:);
WindowRange = [BestwindowIndex(1)-60 BestwindowIndex(end)+60];
else
Window = ([nan nan nan nan nan nan nan nan]);
WindowRange = [nan nan];
end
end
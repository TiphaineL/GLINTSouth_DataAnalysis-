function [allData,allTimes,allDarkData] = extractData(filePath,...
    filePrefix,startTimeString,endTimeString,darkFileSpecify)
%%% Read the data file, save the raw data into a big array, 
%%%  convert the times and substract the dark bias
%%% t1 is the starting time string for the first file
%%% t2 the end time
%%% G the gain of the channels
%%% Dark a list of manulally specified dark files

fileExtn = '.bin';
gain = 1;
channelGains = [1, 1, 1, 1]; % Multiply each channel by this gain
% filePath = path;
% startTimeString1 = t1;
% endTimeString1 = t2;
% channelGains = G;
% filePrefix = prefix;

if exist('Dark','var')
    darkFilesSpecify = Dark;
else
    darkFilesSpecify = {};
end

% Get the time from the file name and format it
formatIn = 'yyyymmddTHHMMSS';
startTimeNum = datenum(startTimeString,formatIn);
endTimeNum = datenum(endTimeString,formatIn);


% List all the files
listing = dir([filePath '*' fileExtn]);
allFileNames = { listing.name };
nAllFiles = length(allFileNames);
fCount = 1;

pLength = length(filePrefix);

% Eventually put all data into 1 matrix for simplicity
nChans=4;
allData = zeros(nChans, 0);
allDataErrs = zeros(nChans, 0);
allTimes = [];
allElapsedTimes = [];
allDarkElapsedTimes = [];
allDarkData = zeros(nChans, 0);
allDarkTimes = [];
allDarkAbsTimes = []; % The absolute time (since start of data) 
                  % of each dark file

tic
clear ch0Av ch1Av ch2Av ch3Av
for k = 1:nAllFiles
    skipThisFile = false;
    curName = allFileNames{k};

    % If filename is in the wrong format, ignore this file
    try
        % Check if it's a dark
        dchk = strfind(curName, 'DARK');
        if length(dchk) > 0 %#ok<ISMT>
            darkFileStatus = true;
            curTimeStr = curName(pLength+6:pLength+6+15);
        else
            darkFileStatus = false;
            curTimeStr = curName(pLength+1:pLength+1+15);
        end

        % Include manually specified dark files
        if ~isempty(darkFilesSpecify)
            for s = 1:length(darkFilesSpecify)
                check = strfind(curName, darkFilesSpecify{s});
                if length(check) > 0 %#ok<ISMT>
                    darkFileStatus = true;
                end
            end
        end
% 
%         % Check if it's the specified custom filename format
%         if useCustomFilenameFormat
%             cchk = strfind(curName, customIDString);
%             if isempty(cchk)
%                 skipThisFile = true; %Ignore file unless it matches
%             end
%         end

%         % Check it doesn't match the exclude string
%         if ~isempty(excludeString)
%             echk = strfind(curName, excludeString);
%             if ~isempty(echk)
%                 skipThisFile = true;
%             end
%         end
        
        curTimeNum = datenum(curTimeStr,formatIn);
    catch ME
        %msgText = getReport(ME);
        msgText = ME.identifier;
        disp(['Ignored file ' curName ' because of error: ' msgText])
        %disp(msgText)
        skipThisFile = true;
    end


    if skipThisFile
        curTimeNum = 0; %Force this file to be skipped
    end

    if (curTimeNum >= startTimeNum) && (curTimeNum <= endTimeNum)

        isDark(fCount) = darkFileStatus;

        % Read this file and save its statistics
        filestring=[filePath curName];
        disp(['Reading ' filestring])

        fid = fopen(filestring,'r');
        [data,count] = fread(fid,[5,inf],'double');
        fclose(fid);

%         if swapChs23
%         	disp('WARNING - swapping null and anti-null channels')
%             data = data([1 2 4 3 5], :);
%         end

        if length(data) > 2 % Skip 'empty' files

            time = data(1,:);
            ch0 = data(2,:) * channelGains(1);
            ch1 = data(3,:) * channelGains(2);
            ch2 = data(4,:) * channelGains(3);
            ch3 = data(5,:) * channelGains(4);   

            % Store fle averages for later plotting
            ch0Av(fCount) = mean(ch0)/gain;
            ch1Av(fCount) = mean(ch1)/gain;
            ch2Av(fCount) = mean(ch2)/gain;
            ch3Av(fCount) = mean(ch3)/gain;
            timeNums(fCount) = curTimeNum;

            rawTime = time;
            if ~darkFileStatus
                allData = [allData [ch0; ch1; ch2; ch3]];

                % Start new time at end of old time (so discontinuities
                % will happen - be careful if FFTing, etc.)
                tStep = time(2) - time(1);
                if ~isempty(allTimes)
                    startTime = allTimes(end) + tStep;
                    time = time + startTime;
                end
                allTimes = [allTimes time];

                % Also populate elapsed time in seconds
                if fCount == 1
                    startTime = 0;
                else
                    startTime = (timeNums(fCount) - timeNums(1))...
                        *24*60*60; %Make it elapsed time in secs.
                end
                eltime = rawTime + startTime;
                allElapsedTimes = [allElapsedTimes eltime];
            end

            if darkFileStatus
                allDarkData = [allDarkData [ch0; ch1; ch2; ch3]];

                % Start new time at end of old time (so discontinuities
                % will happen - be careful if FFTing, etc.)
                tStep = time(2) - time(1);
                if ~isempty(allDarkTimes)
                    startTime = allDarkTimes(end) + tStep;
                    newTimes = time + startTime;
                else
                    newTimes = time;
                end
                allDarkTimes = [allDarkTimes newTimes];

                % Also populate elapsed time in seconds
                if fCount == 1
                    startTime = 0;
                else
                    startTime = (timeNums(fCount) - timeNums(1))...
                        *24*60*60; %Make it elapsed time in secs.
                end
                eltime = rawTime + startTime;
                allDarkElapsedTimes = [allDarkElapsedTimes eltime];
            end

            clear ch0;
            clear ch1;
            clear ch2;
            clear ch3;
            clear time;
            clear data;

            fCount = fCount + 1;
        else
            disp('Skipping this file - not enough data.')
        end
    end
end  


disp(['Total num files: ' num2str(fCount-1)])

timeNumsE = (timeNums - timeNums(1))*24*60*60; %Make it elapsed time in s
s1ix = find(isDark == false);
s2ix = find(isDark == true);
% Assumes set 2 is dark
bias0 = mean(ch0Av(s2ix));
bias1 = mean(ch1Av(s2ix));
bias2 = mean(ch2Av(s2ix));
bias3 = mean(ch3Av(s2ix));


       
% allData(1,:) = allData(1,:) - bias0;
% allData(2,:) = allData(2,:) - bias1;
% allData(3,:) = allData(3,:) - bias2;
% allData(4,:) = allData(4,:) - bias3; 
% 
%      
% % In either case, subtract a constant bias from the averages. These
% % are only used for plotting, and it's useful to see the trend.
% ch0Av(s1ix) = ch0Av(s1ix) - bias0;
% ch1Av(s1ix) = ch1Av(s1ix) - bias1;
% ch2Av(s1ix) = ch2Av(s1ix) - bias2;
% ch3Av(s1ix) = ch3Av(s1ix) - bias3;
% ch0Av(s2ix) = ch0Av(s2ix) - bias0;
% ch1Av(s2ix) = ch1Av(s2ix) - bias1;
% ch2Av(s2ix) = ch2Av(s2ix) - bias2;
% ch3Av(s2ix) = ch3Av(s2ix) - bias3;
toc
end




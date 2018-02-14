function ADOfflineModeDisplay(offlineData,params)
%This function displays a demo of the previously recorded session.
%inputs -   recordedData is a 2X1 cell of structs containing all recorded
%           data.

%% load params for show
numS = length(offlineData);
numD = params.numOfDrums;
drumR = params.drumR;
numS = 2;
for s = 1:numS %stick loop
    for pos = 1:length(offlineData{s}) %pos loop
        if offlineData{s}(pos).found
            stickPos(pos,:,s) = [offlineData{s}(pos).x offlineData{s}(pos).y offlineData{s}(pos).shift];
        else 
            stickPos(pos,:,s) = nan(1,3);
        end
    end %end pos loop
end %end stick loop

%% get frame bounds

Zvals = squeeze(stickPos(:,3,:));
Zvals = Zvals(~isnan(Zvals));
[Ybound,Xbound, ~] = size(offlineData{1}(1).frame); 
medZ = median(Zvals);
Zbound = [medZ-10 medZ+10];
%Zbound = [min(min(stickPos(:,3,:))) max(max(stickPos(:,3,:)))];
trLen = 1;
trail = [1:trLen];
alphaValues = linspace(0,1,trLen)'; %for transparency
colors = {'r','b'};

%% main loop
figure;
for pos = 1:length(offlineData{s}) - trLen %pos loop
    subplot(1,2,1);
    for alphaInd = 1:length(alphaValues)
        for stickInd = [1:numS]
%             scatter3(stickPos(pos + alphaInd - 1,1,stickInd),stickPos(pos + alphaInd - 1,2,stickInd),...
%                 stickPos(pos + alphaInd - 1,3,stickInd),...
%                 'MarkerFaceColor',colors{stickInd},'MarkerEdgeColor',colors{stickInd},'MarkerFaceAlpha',...
%                 alphaValues(alphaInd),'MarkerEdgeAlpha',alphaValues(alphaInd));
            stem3(stickPos(pos + alphaInd - 1,1,stickInd),stickPos(pos + alphaInd - 1,2,stickInd),...
                stickPos(pos + alphaInd - 1,3,stickInd),colors{stickInd});
            hold all;
            grid on;
            axis([1 Xbound 1 Ybound Zbound]);          
            xlabel('X'); ylabel('Y'); zlabel('Z')
        end
    end
    hold off;
    
    subplot(1,2,2);
    imshow(offlineData{1}(pos).frame);
    hold all;
    for alphaInd = 1:length(alphaValues)
        for stickInd = [1:numS]
            scatter(stickPos(pos + alphaInd - 1,1,stickInd),stickPos(pos + alphaInd - 1,2,stickInd),...
                'MarkerFaceColor',colors{stickInd},'MarkerEdgeColor',colors{stickInd},'MarkerFaceAlpha',...
                alphaValues(alphaInd),'MarkerEdgeAlpha',alphaValues(alphaInd));
            grid on;
            axis([1 Xbound 1 Ybound]);          
            xlabel('X'); ylabel('Y');
        end
    end
    hold off;
    
    
    
    
    %     drawnow;
    %     clearpoints(h);
    %     addpoints(h,stickPos{1}(pos + trail,1),stickPos{1}(pos + trail,2),stickPos{1}(pos + trail,3));
    
    
    %     stem3(stickPos{1}(pos,1),stickPos{1}(pos,2),stickPos{1}(pos,3));
    %         %'MarkerFaceColor','r','MarkerEdgeColor','r','MarkerFaceAlpha'...
    %         %,alphaValues(alphaInd),'MarkerEdgeAlpha',alphaValues(alphaInd));
    %     hold all;
    %end
    %     scatter3(trailB(alphaInd,1),trailB(alphaInd,2),trailB(alphaInd,3),'MarkerFaceColor','b','MarkerEdgeColor','b',...
    %         'MarkerFaceAlpha',alphaValues(alphaInd),'MarkerEdgeAlpha',alphaValues(alphaInd));
    %hold off;
    pause(.05);
end %end pos loop

end

clear;
params = ADLoadParams();

params.numOfSticks = 2;
params.playerPosition = [135 20];
params.drums{1}.shift = 5;
params.drums{2}.shift = 3.5;
params.drums{3}.shift = 2;
params.minAngle = 30;
params.maxAngle = 170;
params.numOfDrums = 3;
params.drumsYLine = 95;

record.recordStickLoc = true;
record.recordFrames = true;
record.recordTime = 20;
cams(1) = webcam(2);
cams(2) = webcam(3);

saveStr = mainRunFunc('Live', cams, record, [], params);
input('Press any key to see your recording!')
mainRunFunc('Test', cams, [], saveStr, []);
close all;
%delete [saveStr, '.mat']
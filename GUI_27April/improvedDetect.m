% function improvedDetect
    clc;close all;clear;
    chocImage = imread('all.png');
%     chocImage = imread('Training set/all.jpg');
    imshow(chocImage);
    [c] = findChoc(chocImage);


    disp('END OF RUN');




% end
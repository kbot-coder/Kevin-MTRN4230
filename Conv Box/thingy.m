clear;clc;figure(1);
im = imread('1.jpg');
imshow(im);
ax1 = gca;
% set(ax1,'color','none');
ax1_pos = ax1.Position; 
ax2 = axes('Position',ax1_pos,...
    'Color','none');


plot([1 2 6 10 0], [1 5 6 0 10],'parent',ax2,'Color','r',gcf, 'Color', 'None');
set(gca,'color','none');
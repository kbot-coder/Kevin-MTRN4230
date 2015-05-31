function tempStr = data2str(chocStat,row,check)
    
    if strcmp(check,'string')
        % # use HTML to style these cells
        tempStr = chocStat;
        tempStr(row,:) = strcat(...
            '<html><body bgcolor="#FFFF80" text="#FF0000" width="100px">', ...
            chocStat(row,:), ...
            '</span></html>');    
        return;
    end
    
%     mine = chocStat(:,1:3);
     mine = chocStat;
     
    %# convert matrix of numbers to cell array of strings (right aligned)
    tempStr = reshape(strtrim(cellstr(num2str(mine(:)))),...
        size(mine));
    k = size(chocStat);
    
    %# save the flavour in strings. only for chocolates
% % % % %     try
% % % % %         for i=1:k(1)
% % % % %             switch chocStat(i,6)
% % % % %                 case 1
% % % % %                     tempStr(i,4) = {'Milk'};
% % % % %                 case 2
% % % % %                     tempStr(i,4) = {'Dark'};
% % % % %                 case 3
% % % % %                     tempStr(i,4) = {'Orange'};
% % % % %                 case 4 
% % % % %                     tempStr(i,4) = {'Mint'};
% % % % %                 otherwise    
% % % % %                     tempStr(i,4) = {'Unknown'};                 
% % % % %             end 
% % % % %         end
% % % % %     catch
% % % % %     end
    if row>0
        % # use HTML to style these cells
        tempStr(row,:) = strcat(...
            '<html><body bgcolor="#FFFF80" text="#FF0000" width="100px">', ...
            tempStr(row,:), ...
            '</span></html>');
    end
end
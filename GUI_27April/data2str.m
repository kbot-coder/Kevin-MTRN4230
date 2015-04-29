function tempStr = data2str(chocStat,collum,check)
    
    if strcmp(check,'string')
        % # use HTML to style these cells
        tempStr = chocStat;
        tempStr(collum,:) = strcat(...
            '<html><body bgcolor="#FFFF80" text="#FF0000" width="100px">', ...
            chocStat(collum,:), ...
            '</span></html>');    
        return;
    end
    
    mine = chocStat(:,1:3);
    
    %# convert matrix of numbers to cell array of strings (right aligned)
    tempStr = reshape(strtrim(cellstr(num2str(mine(:)))),...
        size(mine));
    k = size(chocStat);
    
    %# save the flavour in strings
    for i=1:k(1)
        switch chocStat(i,6)
            case 1
                tempStr(i,4) = {'Milk'};
            case 2
                tempStr(i,4) = {'Dark'};
            case 3
                tempStr(i,4) = {'Orange'};
            case 4 
                tempStr(i,4) = {'Mint'};
            otherwise    
                tempStr(i,4) = {'Unknown'};                 
        end 
    end
    if collum>0
        % # use HTML to style these cells
        tempStr(collum,:) = strcat(...
            '<html><body bgcolor="#FFFF80" text="#FF0000" width="100px">', ...
            tempStr(collum,:), ...
            '</span></html>');
    end
end
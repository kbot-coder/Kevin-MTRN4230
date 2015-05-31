function flv = str2flv(flStr)
switch flStr
    case 'none'
        flv = 0;
    case 'milk'
        flv = 1;
    case 'dark'
        flv = 2;
    case 'orange'
        flv = 3;
    case 'mint'
        flv = 4;        
end
end
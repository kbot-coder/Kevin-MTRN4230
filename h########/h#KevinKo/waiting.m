function waiting()
    c_loop ='RED';
    while strcmp(c_loop,'GREEN')== 0
        pause(0.5);
        c_loop = robSTAT;
    end
end

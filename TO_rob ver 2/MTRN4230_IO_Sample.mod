MODULE MTRN4230_IO_Sample
    PERS  robjoint IO_signal;
    PERS speeddata speed_value;
    PERS bool start_IO;
    
    PROC MainIO()
        
        WaitUntil start_IO;
        
        !vaccumm ON OFF       
        IF IO_signal.rax_1 = 1 THEN
             TurnVacOn;
        ELSEIF IO_signal.rax_1 = 0 THEN
             TurnVacOff;
        ELSE
        ENDIF
        
        !solenoid on off
        IF    IO_signal.rax_2 = 1 THEN
             TurnSolenoidOn;
        ELSEIF IO_signal.rax_2 = 0 THEN
             TurnSolenoidOff;
        ELSE
        ENDIF      
        
        ! converyor on off
        IF    IO_signal.rax_3 = 1 THEN
             TurnConOn;
        ELSEIF IO_signal.rax_3 = 0 THEN
             TurnConOff;
        ELSE
        ENDIF    
        
        !conveyor direction 
        IF    IO_signal.rax_4 = 1 THEN
            Conforward;
        ELSEIF IO_signal.rax_4 = 0 THEN
             Conbackward;
        ELSE
        ENDIF   
        
        !set speed
        speed_value.v_tcp := IO_signal.rax_5;
        start_IO:=FALSE;
    ENDPROC
    
    PROC TurnVacOn()
        
        ! Set VacRun on.
        SetDO DO10_1, 1;
        
    ENDPROC
    
   
    PROC TurnVacOff()
        
        ! Set VacRun off.
        SetDO DO10_1, 0;
        
    ENDPROC
    
    PROC TurnSolenoidOn()
        
        ! Setsolenoid on.
        SetDO DO10_2, 1;
        
    ENDPROC
    
    PROC TurnSolenoidOff()
        
        ! Setsolenoid on.
        SetDO DO10_2, 0;
        
    ENDPROC
    
    
    PROC TurnConOn()
        
        ! An example of how an IF statement is structured.
        ! DI10_1 is 'ConStat', and will only be equal to 1 if the conveyor is on and ready to run.
        ! If it is ready to run, we will run it, if not, we will set it off so that we can fix it.
       ! IF DI10_1 = 1 THEN
            !turn conveyor off
            SetDO DO10_3, 1;
       ! ELSE
       !     SetDO DO10_3, 0;
       ! ENDIF
        
    ENDPROC
    
    PROC TurnConOff()
        !turn conveyor of
        SetDO DO10_3, 0;
    ENDPROC
    
     
    PROC Conforward()
        SetDO DO10_4, 1;
    ENDPROC
 
    PROC Conbackward()
        SetDO DO10_4, 0;
    ENDPROC
    
ENDMODULE

MODULE Task_1
     
    PERS robtarget target;
    PERS bool startTask1 := FALSE;
    PERS num mode := 0;
    PERS speeddata speed_value;
    PERS bool move_please;
    PERS bool startalert:=TRUE;
    PERS bool ROBDONE;
    ! The Main procedure. When you select 'PP to Main' on the FlexPendant, it will go to this procedure.
    PROC MainMove()
       
        !VAR robjoint jointsJ ;
        !VAR pos targetL;
        !VAR pos targetL_J;
        
        WaitUntil startTask1;
        ROBDONE:=FALSE;
        !startalert:= TRUE;
        !jointsJ:=jointpos;
        !targetL:= position;
           
        weAllLoveMTRN mode, target ;    
    
        startTask1:=FALSE;
        ROBDONE:= TRUE;
    ENDPROC
    
    PROC weAllLoveMTRN(num iWantThis, robtarget  target)
    VAR robtarget temp;

        temp:=target;
        temp.trans.z := 200;
          
         IF iWantThis = 0 THEN
                !move 
                
                MoveJ temp, speed_value,fine,tSCup;
                
                MoveL target, speed_value, fine, tSCup;
            
          !  ELSEIF iWantThis = 1  THEN
                !move joint
                
              !  MoveAbsJ [jointsJ,[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]], speed_value, fine, tSCup;
                
            !ELSEIF iWantThis =2 THEN
                
                !MoveToCalibPos;
                
            !ELSEIF iWantThis = 4 THEN
                !MoveJ ([targetL_J,[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]), speed_value,fine,tSCup;
                
            ENDIF
            
    ENDPROC
          
   
    
ENDMODULE
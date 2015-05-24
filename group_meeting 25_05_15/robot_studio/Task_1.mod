MODULE Task_1
     
    PERS robtarget target;
    PERS bool startTask1 := FALSE;
    PERS num mode;
    PERS speeddata speed_value;
    PERS bool move_please;
    PERS bool startalert:=TRUE;
    PERS bool ROBDONE;
    PERS bool rob_stat;
    ! The Main procedure. When you select 'PP to Main' on the FlexPendant, it will go to this procedure.
    PROC MainMove()
        startTask1:=FALSE;       
        !VAR robjoint jointsJ ;
        !VAR pos targetL;
        !VAR pos targetL_J;
        ClearPath; 
        WaitUntil startTask1;
        rob_stat:= TRUE;
        ROBDONE:=FALSE;
        !startalert:= TRUE;
        !jointsJ:=jointpos;
        !targetL:= position;
           
        weAllLoveMTRN mode, target ;    
    
        startTask1:=FALSE;
        ROBDONE:= TRUE;

        ERROR
        IF ERRNO = ERR_PATH_STOP THEN
        RETRY;
            
        ENDIF
        IF ERRNO = ERR_PATHDIST THEN
        RETRY;
            
        ENDIF
       IF ERRNO = ERR_PATH THEN

        RETRY;

        ENDIF 
    ENDPROC
    
    PROC weAllLoveMTRN(num iWantThis, robtarget  target)
    VAR robtarget temp;

        temp:=target;
        temp.trans.z := target.trans.z +100;
          
         IF iWantThis = 0 THEN
                !move 
                
                MoveJ temp, speed_value,fine,tSCup;
                
                MoveL target, speed_value, fine, tSCup;
            
          ELSEIF iWantThis = 1  THEN
                !move joint
                MoveL target, speed_value, fine, tSCup;
              !  MoveAbsJ [jointsJ,[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]], speed_value, fine, tSCup;
                
            !ELSEIF iWantThis =2 THEN
                
                !MoveToCalibPos;
                
            !ELSEIF iWantThis = 4 THEN
                !MoveJ ([targetL_J,[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]), speed_value,fine,tSCup;
                
            ENDIF
ERROR
IF ERRNO = ERR_PATH_STOP THEN

ClearPath;
StartMove;

RETURN;

ENDIF 

IF ERRNO = ERR_PATHDIST THEN

ClearPath;
RETURN;

ENDIF 
IF ERRNO = ERR_PATH THEN

ClearPath;
RETURN;

ENDIF 

    ENDPROC
          
   
    
ENDMODULE
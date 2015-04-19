MODULE ReadRobStatus

    VAR socketdev client_socket;
    VAR socketdev temp_socket;
    CONST string host:="127.0.0.1";
    CONST num port:=1025;
    VAR bool keep_listening := TRUE;
    VAR string recieved_string := "";
    
    VAR robtarget position;
    VAR jointtarget joint;
    
    VAR string strP;
    VAR string strJ;
    VAR string strIO;
    
    VAR dionum DO_1;
    VAR num DO_2;
    VAR num DO_3;
    VAR num DO_4;
    VAR num DI_1;
    
    VAR bool init:=TRUE;
    
    PROC MainRead()
        
        ReadEndeffPos;
        ReadJointPos;        
        ReadIOStat;
        ConvToString;
        SendStatus;
        
    ENDPROC
    
    PROC SendStatus()
        IF init THEN
        SocketCreate temp_socket;
        SocketBind temp_socket, host, port;
        SocketListen temp_socket;
        !WHILE keep_listening DO
        SocketAccept temp_socket, client_socket;
        init := FALSE;
        ENDIF
        SocketSend client_socket \Str:=(strP+" "+strJ+" "+strIO+" "+"\0A");
        WaitTime 0.1;
        SocketClose temp_socket;
    ENDPROC

    PROC ConvToString()
        strP := "Pos:"+ValToStr(position.trans);
        strJ := "Theta: "+ValToStr(joint.robax);
        strIO := "IO: "+"["+ValToStr(DI_1)+","+ValToStr(DO_1)+","+ValToStr(DO_2)+","+ValToStr(DO_3)+","+ValToStr(DO_4)+"]";
    ENDPROC
    PROC ReadIOStat()
        
        IF DI10_1 = 1 THEN
            DI_1 := 1;
        ELSE
            DI_1 := 0;
        ENDIF
        
        IF DOutput(DO10_1) = 1 THEN
            DO_1 := 1;
        ELSE
            DO_1 := 0;
        ENDIF
        
        IF DOutput(DO10_2) = 1 THEN
            DO_2 := 1;
        ELSE
            DO_2 := 0;
        ENDIF
        
        IF DOutput(DO10_3) = 1 THEN
            DO_3 := 1;
        ELSE
            DO_3 := 0;
        ENDIF
        
        IF DOutput(DO10_4) = 1 THEN
            DO_4 := 1;
        ELSE
            DO_4 := 0;
        ENDIF
       
    ENDPROC
    
    PROC ReadEndeffPos()
        position:=CRobT(\TaskName:="T_ROB1");
        position.trans.x := Trunc(position.trans.x \Dec:=0);
        position.trans.y := Trunc(position.trans.y \Dec:=0);
        position.trans.z := Trunc(position.trans.z \Dec:=0);
    ENDPROC
    
    PROC ReadJointPos()
        joint:=CJointT(\TaskName:="T_ROB1");
        joint.robax.rax_1:=Trunc(joint.robax.rax_1 \Dec:=0);
        joint.robax.rax_2:=Trunc(joint.robax.rax_2 \Dec:=0);
        joint.robax.rax_3:=Trunc(joint.robax.rax_3 \Dec:=0);
        joint.robax.rax_4:=Trunc(joint.robax.rax_4 \Dec:=0);
        joint.robax.rax_5:=Trunc(joint.robax.rax_5 \Dec:=0);
        joint.robax.rax_6:=Trunc(joint.robax.rax_6 \Dec:=0);
    ENDPROC

ENDMODULE
MODULE ReadRobStatus
    ! Prepare the socket for TCP connection with the client
    ! in this case, matlab will be the client software.
    ! ------------------------------------------------------
    VAR socketdev client_socket;
    VAR socketdev temp_socket;
    CONST string host:="127.0.0.1";
    CONST num port:=1026;
    
    ! Set a variable for storing current endeffector position
    ! and joint angles.
    ! ------------------------------------------------------
    VAR robtarget position;
    VAR jointtarget joint;
    
    ! Prepare strings variable to store data in string format
    ! Because TCP socket can only recieve string format
    !--------------------------------------------------------
    VAR string strP;
    VAR string strJ;
    VAR string strIO;
    
    ! Variables to store the I/O value
    VAR dionum DO_1;
    VAR num DO_2;
    VAR num DO_3;
    VAR num DO_4;
    VAR num DI_1;
    
    PROC MainRead()  ! Main function
        
        ReadEndeffPos;  ! Read endeffector position
        ReadJointPos;   ! Read joints angle position
        ReadIOStat;     ! Read digital I/O signal
        ConvToString;   ! Convert read data into strings
        SendStatus;     ! Send data to client
               
    ENDPROC
   
    ! Sending the status of the robot to the client
    PROC SendStatus()

        SocketCreate temp_socket;                ! Create temporary socket
        SocketBind temp_socket, host, port;      ! Bind temp socket with the client socket
        SocketListen temp_socket;                ! Listen connection from temp socket
        SocketAccept temp_socket, client_socket; ! Accept connection from client

        ! Send data to client through the socket
        SocketSend client_socket \Str:=(strP+strJ+strIO+"\0A");
        
        SocketClose temp_socket;    ! Close temporary socket
        SocketClose client_socket;  ! Close client socket
        
    ENDPROC
    
    ! Convert the joints and position value to string
    PROC ConvToString()
        strP := ValToStr(position.trans);   ! convert positon value to string
        strJ := ValToStr(joint.robax);      ! convert joint value to string
        
        ! convert input/output signal value to string
        strIO := "["+ValToStr(DI_1)+","+ValToStr(DO_1)+","+ValToStr(DO_2)+","+ValToStr(DO_3)+","+ValToStr(DO_4)+"]";
    ENDPROC
    
    ! read the current I/O signal status
    PROC ReadIOStat()
        
        ! read and store the value to DI_1, DO_1, DO_2, DO_3, DO_4 so it can
        ! be converted into strings
        
        IF DI10_1 = 1 THEN  ! Check current input 1 status
            DI_1 := 1;
        ELSE
            DI_1 := 0;
        ENDIF
        
        IF DOutput(DO10_1) = 1 THEN  ! Check current output 1 status
            DO_1 := 1;
        ELSE
            DO_1 := 0;
        ENDIF
        
        IF DOutput(DO10_2) = 1 THEN  ! Check current output 2 status
            DO_2 := 1;
        ELSE
            DO_2 := 0;
        ENDIF
        
        IF DOutput(DO10_3) = 1 THEN  ! Check current output 3 status
            DO_3 := 1;
        ELSE
            DO_3 := 0;
        ENDIF
        
        IF DOutput(DO10_4) = 1 THEN  ! Check current output 4 status
            DO_4 := 1;
        ELSE
            DO_4 := 0;
        ENDIF
       
    ENDPROC
    
    ! read current endeffector position
    PROC ReadEndeffPos()
        position:=CRobT(\TaskName:="T_ROB1");   ! Read the endeffector position from task 1
        
        ! Truncate the value into 0 decimal places for each x,y,z coordinate
        position.trans.x := Trunc(position.trans.x \Dec:=0);
        position.trans.y := Trunc(position.trans.y \Dec:=0);
        position.trans.z := Trunc(position.trans.z \Dec:=0);
    ENDPROC
    
    ! read current joint angle
    PROC ReadJointPos()
        joint:=CJointT(\TaskName:="T_ROB1");    ! Read the joint angle from task 1
        
        ! Truncate the value into 0 decimal places for each joints value
        ! i.e. joint 1, joint 2, joint 3, joint 4, joint 5 and joint 6
        
        joint.robax.rax_1:=Trunc(joint.robax.rax_1 \Dec:=0);
        joint.robax.rax_2:=Trunc(joint.robax.rax_2 \Dec:=0);
        joint.robax.rax_3:=Trunc(joint.robax.rax_3 \Dec:=0);
        joint.robax.rax_4:=Trunc(joint.robax.rax_4 \Dec:=0);
        joint.robax.rax_5:=Trunc(joint.robax.rax_5 \Dec:=0);
        joint.robax.rax_6:=Trunc(joint.robax.rax_6 \Dec:=0);
    ENDPROC

ENDMODULE
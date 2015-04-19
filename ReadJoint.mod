MODULE ReadJoint

    VAR socketdev matlab_socket;
    CONST string host:="127.0.0.1";
    CONST num port:=1025;
    
    VAR robtarget position;
    VAR jointtarget joint;
    VAR string strP;
    VAR string strJ;
    VAR num i := 1;
    PROC MainRead()
        
        !IF i = 1 THEN
        ListenForAndAcceptConnection;
           ! i := 0;
       ! ENDIF

        position:=CRobT(\TaskName:="T_ROB1");
        position.trans.x := Trunc(position.trans.x \Dec:=0);
        position.trans.y := Trunc(position.trans.y \Dec:=0);
        position.trans.z := Trunc(position.trans.z \Dec:=0);
        
        !\Tool:=tsCup \WObj:=wTable);
        joint:=CJointT(\TaskName:="T_ROB1");
        joint.robax.rax_1:=Trunc(joint.robax.rax_1 \Dec:=0);
        joint.robax.rax_2:=Trunc(joint.robax.rax_2 \Dec:=0);
        joint.robax.rax_3:=Trunc(joint.robax.rax_3 \Dec:=0);
        joint.robax.rax_4:=Trunc(joint.robax.rax_4 \Dec:=0);
        joint.robax.rax_5:=Trunc(joint.robax.rax_5 \Dec:=0);
        joint.robax.rax_6:=Trunc(joint.robax.rax_6 \Dec:=0);
        
        !TPWrite("Position = "+ValToStr(position.trans));
        !TPWrite("Joint = "+ValToStr(joint.robax));

        strP:=ValToStr(position.trans);
        strJ:=ValToStr(joint.robax);
        
        !TPWrite(strP);
        !TPWrite(strJ);

        SocketSend matlab_socket \Str:=strP;
        SocketSend matlab_socket \Str:=strJ;
        CloseConnection;

        !ReadJointPos;

    ENDPROC

    PROC ReadJointPos()

        VAR jointtarget joints;
        joints:=CJointT(\TaskName:="T_ROB1");

    ENDPROC

    PROC SendJointAngle(pos end_eff)
        VAR string str;

        str:=ValToStr(end_eff);

        SocketSend matlab_socket\Str:=(str);

    ENDPROC

    PROC ListenForAndAcceptConnection()

        ! Create the socket to listen for a connection on.
        VAR socketdev welcome_socket;
        SocketCreate welcome_socket;

        ! Bind the socket to the host and port.
        SocketBind welcome_socket,host,port;

        ! Listen on the welcome socket.
        SocketListen welcome_socket;

        ! Accept a connection on the host and port.
        SocketAccept welcome_socket,matlab_socket;

        ! Close the welcome socket, as it is no longer needed.
        SocketClose welcome_socket;

    ENDPROC


    PROC CloseConnection()
        !SocketClose matlab_socket;
    ENDPROC

ENDMODULE
MODULE ReadJoint
    
    VAR socketdev matlab_socket;
    CONST string host := "127.0.0.1";
    CONST num port := 1025;
    
    PROC MainRead()
                
        VAR pos end_eff := [90,90,30];
        
        ListenForAndAcceptConnection;
        SendJointAngle end_eff;
        
        CloseConnection;
        
        
        !ReadJointPos;
        
    ENDPROC
    
   PROC ReadJointPos()
        
       VAR jointtarget joints;
       joints := CJointT(\TaskName:= "T_ROB1");
        
   ENDPROC
    
    PROC SendJointAngle(pos end_eff)
        VAR string str;
        
        str := ValToStr(end_eff);
        
        SocketSend matlab_socket \Str:=(str);
        
    ENDPROC
    
     PROC ListenForAndAcceptConnection()
        
        ! Create the socket to listen for a connection on.
        VAR socketdev welcome_socket;
        SocketCreate welcome_socket;
        
        ! Bind the socket to the host and port.
        SocketBind welcome_socket, host, port;
        
        ! Listen on the welcome socket.
        SocketListen welcome_socket;
        
        ! Accept a connection on the host and port.
        SocketAccept welcome_socket, matlab_socket;
        
        ! Close the welcome socket, as it is no longer needed.
        SocketClose welcome_socket;
        
    ENDPROC
    
    PROC CloseConnection()
        SocketClose matlab_socket;
    ENDPROC
    
ENDMODULE
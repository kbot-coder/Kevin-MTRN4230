MODULE STATUS_ROB
    VAR socketdev client_socket;
    PERS bool ROBDONE;
    PERS bool rob_stat:=TRUE;
    VAR bool ROBDONE_last:= TRUE;
    VAR num i:=0;
    CONST string host:="127.0.0.1";
    CONST num port_stat:=1028;
    
    
    
PROC Main()
    
    WaitUntil rob_stat;
   
    IF ROBDONE = FALSE THEN
        
        send_status "BUSY";
        TPPRINT("BUSY"); 
        CloseConnection;
        i:=0;    
    ELSEIF ROBDONE = TRUE AND i=0 THEN
        send_status "REDE";
        TPPRINT("REDE"); 
        rob_stat:= FALSE;
        CloseConnection;
       
    ENDIF
    
    
    ERROR
        IF ERRNO = ERR_SOCK_TIMEOUT THEN
            RETRY;
            
        ENDIF
        IF ERRNO = ERR_SOCK_CLOSED THEN
            RETRY;
        ENDIF
        
ENDPROC

PROC send_status(string msg)
    ! Create the socket to listen for a connection on.
        VAR socketdev welcome_socket;
        SocketCreate welcome_socket;

        ! Bind the socket to the host and port.
        SocketBind welcome_socket,host,port_stat;

        ! Listen on the welcome socket.
        SocketListen welcome_socket;

        ! Accept a connection on the host and port.
        SocketAccept welcome_socket,client_socket \Time:=100;
        !send msg
        SocketSend client_socket \Str:=msg;
        !SocketSend client_socket \Str:=("HERE");
        ! Close the welcome socket, as it is no longer needed.
        SocketClose welcome_socket;
    
ENDPROC

PROC CloseConnection()
        SocketClose client_socket;
ENDPROC
    
ENDMODULE
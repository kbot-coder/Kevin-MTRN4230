MODULE STATUS_ROB
    VAR socketdev client_socket;
    PERS bool ROBDONE;
    CONST string host:="127.0.0.1";
    CONST num port_stat:=1028;
    
PROC Main()
    
    send_status;
    
    CloseConnection;
    
    ERROR
        IF ERRNO = ERR_SOCK_TIMEOUT THEN
            RETRY;
            
        ENDIF
        IF ERRNO = ERR_SOCK_CLOSED THEN
            RETRY;
        ENDIF
        
ENDPROC

PROC send_status()
    ! Create the socket to listen for a connection on.
        VAR socketdev welcome_socket;
        SocketCreate welcome_socket;

        ! Bind the socket to the host and port.
        SocketBind welcome_socket,host,port_stat;

        ! Listen on the welcome socket.
        SocketListen welcome_socket;

        ! Accept a connection on the host and port.
        SocketAccept welcome_socket,client_socket \Time:=100;
        IF ROBDONE = TRUE THEN
            SocketSend client_socket \Str:=("REDE");
            TPWrite("REDE");
        ELSEIF ROBDONE =FALSE THEN
            SocketSend client_socket \Str:=("BUSY");
            TPWrite("BUSY");
       
        ENDIF
        !SocketSend client_socket \Str:=("HERE");
        ! Close the welcome socket, as it is no longer needed.
        SocketClose welcome_socket;
    
ENDPROC

PROC CloseConnection()
        SocketClose client_socket;
ENDPROC
    
ENDMODULE
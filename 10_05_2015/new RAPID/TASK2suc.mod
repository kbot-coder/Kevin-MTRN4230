MODULE TASK2
   

    ! The socket connected to the client.
    VAR socketdev client_socket;
    
    ! initialize input to be false
    !*************************************
    VAR bool checkpos:=FALSE;
    VAR bool checkjoint:=FALSE;
    VAR bool checkinput:=FALSE;
    VAR bool checkmode:=FALSE;
    VAR bool checkJpos:=FALSE;
    VAR bool checkBind:= FALSE;
    ! ************************************
    VAR num size;
    VAR string received_str;
    PERS robtarget target :=[[175,520,150],[0,0.547722,0.836666,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ! Current robot status value
    ! ***********************************************
    VAR pos position:=[175,520,147]; !position of the robot
    VAR robjoint jointpos:=[0,0,0,0,500,0]; ! for the rotation of the end effector 
    PERS speeddata speed_value:=[300,500,5000,1000];
    PERS robjoint IO_signal :=[0,0.547722,0.836666,0,0,0];
    PERS string signalBind:="";
    ! ***********************************************
    
    PERS pos position_stop; ! store the previous position
    PERS robjoint jointpos_stop; ! store the previous position
    PERS bool selected; !check if input is valid or not
    PERS num mode:=0;
    PERS num task1Trig:=0; !to start task 1
    PERS bool ROBDONE;
    PERS num task3Trig:=0; !to start task 3
    
    ! To prevent Task1, Task2 and Task3 from running
    PERS bool move_please := FALSE;
    PERS bool startTask1:=FALSE;
    PERS bool start_IO:=FALSE;
    
    VAR bool starter:= TRUE;    ! the initialiser
    PERS string signalstop:=""; ! to initialise stop value
   
    ! The host and port that we will be listening for a connection on.
    CONST string host:="127.0.0.1";
    CONST num port:=1025;
    CONST num port1:=1027;
    CONST string start := "START";


    PROC MainServer()
        
        checkpos:=FALSE;
        checkjoint:=FALSE;
        checkinput:=FALSE;
        checkmode:=FALSE;
     
        signalBind:="";
        
        starter_func;
     
        ListenForAndAcceptConnection;

        !Receive a string from the client.
        SocketReceive client_socket\Str:=received_str \Time:=30;
        CloseConnection;
        ! Send the string back to the client, adding a line feed character.        
        TPWrite received_str;
       
        ConvStrtoVal received_str; !convert string to value function
        
        modechecker mode; !check mode function
        getPosition position,jointpos; ! store position and jointpos as target.
        task1Runner task1Trig; ! use o trigger moving task
        
        IOtask; !triger IO 

        
        CloseConnection;
        task1Trig:= 0;
        task3Trig:= 0;
ERROR
        IF ERRNO = ERR_SOCK_TIMEOUT THEN
            RETRY;
            
        ENDIF
        IF ERRNO = ERR_SOCK_CLOSED THEN
            RETRY;
        ENDIF
    ENDPROC

PROC ConvStrToVal(string received_str)
        size:=StrLen(received_str); 
        
        IF size=1 THEN
            !if the signal receive have size =1 store it as mode
            checkmode:=StrtoVal(received_str,mode);
            task1Trig :=0;
            selected := FALSE;
        ELSEIF size = 2 THEN
            signalstop:=received_str;
            
        ELSEIF size = 4 THEN
        
        signalBind:= received_str;
        
        ELSEIF size = 5 THEN
            IF received_str = "START" THEN               
                task1Trig :=1;  ! if size = 5 check if receives_str = start ie string "START" triger task1
            ELSEIF received_str = "STRIO" THEN
                task3Trig:= 1;
            ENDIF
            
        ELSE
            ! the received_str will be store in one of 3 varible
            ! can be position [x,y,z] for position.
            ! [0,0,0,0,0,xxx] for endeffector rotation
            ! [0,1,0,1,100,0] for IO and speed. 1st four is IO, fifth is speed value
            checkpos:=StrtoVal(received_str,position);            
            checkjoint:= StrToVal(received_str,jointpos);
            checkinput:=StrToVal(received_str,IO_signal);
            selected:=FALSE;
            
        ENDIF
      
        
       
ENDPROC
    
PROC modechecker(num mode)
              
    
    IF signalBind = "KNOK" THEN
            
           reply;
           
           
           CloseConnection;
           task1Trig:=0; 
    ENDIF

    IF signalstop = "S1" THEN
        
        position_stop:= position;
         
        jointpos_stop:=jointpos;
        
        StopMove;
        
    ENDIF
    IF signalstop = "S2" THEN
        
        StartMove;
        
        position:= position_stop;
        
        jointpos:=jointpos_stop;
        
        signalstop:="";
        
    ENDIF
    
    IF signalstop = "S3" THEN
     !StopMoveReset;
        !target :=[[180,0,170],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        StopMove;
     ProcerrRecovery \SyncLastMoveInst;
        
    ENDIF
ENDPROC



    PROC task1Runner(num task1Trig)
        
        IF task1Trig=1 THEN
            
            startTask1:=TRUE;
            
        ELSE
            
            startTask1:=FALSE;
            
        ENDIF

    ENDPROC
    
        PROC IOtask()
            
        IF task3Trig = 1 THEN
            
            start_IO:=TRUE;
            
        ELSE
            
            start_IO:=FALSE;
            
        ENDIF

    ENDPROC
    
    PROC getPosition(pos position, robjoint jointpos)
        IF checkpos = TRUE THEN
            target.trans := position;
        ELSEIF checkjoint = TRUE THEN
            target.rot.q1 := jointpos.rax_1;
            target.rot.q2 := jointpos.rax_2;
            target.rot.q3 := jointpos.rax_3;
            target.rot.q4 := jointpos.rax_4;
        ELSE
        ENDIF
        
    ENDPROC
    
PROC reply()
    ! Create the socket to listen for a connection on.
        VAR socketdev welcome_socket;
        SocketCreate welcome_socket;

        ! Bind the socket to the host and port.
        SocketBind welcome_socket,host,port1;

        ! Listen on the welcome socket.
        SocketListen welcome_socket;

        ! Accept a connection on the host and port.
        SocketAccept welcome_socket,client_socket;
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
    PROC ListenForAndAcceptConnection()

        ! Create the socket to listen for a connection on.
        VAR socketdev welcome_socket;
        SocketCreate welcome_socket;

        ! Bind the socket to the host and port.
        SocketBind welcome_socket,host,port;

        ! Listen on the welcome socket.
        SocketListen welcome_socket;

        ! Accept a connection on the host and port.
        SocketAccept welcome_socket,client_socket;

        ! Close the welcome socket, as it is no longer needed.
        SocketClose welcome_socket;
        ERROR
        IF ERRNO = ERR_SOCK_TIMEOUT THEN
            RETRY;
            
        ENDIF
        IF ERRNO = ERR_SOCK_CLOSED THEN
            RETRY;
        ENDIF
 

    ENDPROC

    ! Close the connection to the client.
    PROC CloseConnection()
        SocketClose client_socket;
    ENDPROC

    PROC starter_func()
        
        IF starter = TRUE  THEN
            
            position:=[200,0,147];
            jointpos:=[0,0,0,0,0,0];
            speed_value:=[300,500,5000,1000];
            IO_signal :=[0,0,0,0,100,0];
            starter:= FALSE;
            selected := FALSE;
            move_please:= FALSE;
            checkpos:=FALSE;
            checkjoint:=FALSE;
            checkinput:=FALSE;
            checkmode:=FALSE;
        ENDIF
        
    ENDPROC
    
ENDMODULE
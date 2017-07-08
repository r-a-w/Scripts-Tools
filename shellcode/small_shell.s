BITS 32

; execve(const char *filename, char *const argv [], char *const envp[])
  xor eax, eax    ; zero out eax
  push eax	  ; null terminate the string
  push 0x68732f2f ; Push "//sh" to the stack
  push 0x6e69622f ; Push "/bin" to the stack
  mov ebx, esp	  ; move address of string into ebx
  push eax	  ; place 32 bit null terminator
  mov edx, esp	  ; move empty pointer array to edx		
  push ebx	  ; place address of ebx onto stack
  mov ecx, esp	  ; stack pointer into ecx
  mov al, 11	  ; syscall for execve
  int 0x80	  ; make the syscall
  

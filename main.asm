
default rel

extern MessageBoxA
extern ExitProcess

section .data
    naslov  db "Moj prvi Assembly program", 0
    poruka  db "Zdravo! Ovo je Windows program napisan u NASM-u.", 0
    poruka2 db "Sisaj ga", 0

section .text
    global start

start:
    ; Rezervisemo prostor na steku za Windows x64 pozive
    sub rsp, 40

    ; MessageBoxA(NULL, poruka, naslov, MB_OK)
    xor ecx, ecx
    lea rdx, [rel poruka]
    lea r8,  [rel naslov]
    mov r9d, 0

    call MessageBoxA

    xor ecx, ecx
    lea rdx, [rel poruka2]
    mov r9d,0
    call MessageBoxA
    ; ExitProcess(0)
    xor ecx, ecx
    call ExitProcess

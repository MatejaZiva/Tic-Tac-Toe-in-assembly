;konvenzije za poziv WINDOWS API, param1 = RCX, param2 = RDX, param3 = R8, param4 = R9, param5.... = stack
;volatile registiri (znaci funkcija moze da menja njihovu vrednost) RAX, RCX, RDX, R8-R11
;nonvolatile registri RBX, RBP, RSI, RDI, R12-15

;byte => db, resb
;word => dw, resw
;double word => dd, resd
;quad word => dq, resq

default rel
global start

extern GetModuleHandleA
extern RegisterClassExA
extern messageHandle



struc WNDCLASSEXA
    .cbSize: resd 1
    .style: resd 1
    .lpfnWndProc: resq 1	
    .cbClsExtra: resd 1
    .cbWndExtra: resd 1
    .hInstance: resq 1
    .hIcon: resq 1
    .hCursor: resq 1
    .hbrBackground: resq 1	
    .lpszMenuName: resq 1
    .lpszClassName: resq 1
    .hIconSm: resq 1

endstruc

section .data
    hInstance dq 0
    classNameWindow dd "Name", 0

section .bss
    pWindClassA: resb WNDCLASSEXA_size

section .text

start:

    ; Rezervisemo prostor na steku za Windows x64 pozive
    sub rsp, 8 ;zbog dumbass poravanjenja 16 bytes

    sub rsp, 32 ;garantujemo da ce na stack imati prostor za 4 parametra

    mov rbx, hInstance
    xor rcx, rcx
    call GetModuleHandleA
    mov [rbx], rax


    mov rdx, pWindClassA
    mov dword [rdx + WNDCLASSEXA.cbSize], WNDCLASSEXA_size

    mov dword [rdx + WNDCLASSEXA.style], 3 ;how to draw window when resized

    lea rbx, [messageHandle]
    mov qword [rdx + WNDCLASSEXA.lpfnWndProc], rbx

    mov dword [rdx + WNDCLASSEXA.cbClsExtra], 0

    mov dword [rdx + WNDCLASSEXA.cbWndExtra], 0

    mov rbx, hInstance
    mov qword [rdx + WNDCLASSEXA.hInstance], rbx

    mov qword [rdx + WNDCLASSEXA.hIcon], 0

    mov qword [rdx + WNDCLASSEXA.hCursor], 0 
    
    mov qword [rdx + WNDCLASSEXA.hbrBackground], 6 ; for it to be system white, magic number i know but meh 	

    mov qword [rdx + WNDCLASSEXA.lpszMenuName], 0

    lea rbx, classNameWindow
    mov qword [rdx + WNDCLASSEXA.lpszClassName], rbx 

    mov qword [rdx + WNDCLASSEXA.hIconSm], 0

    mov rcx; zavrsi ovo kontam moze samo dodelix rdx
    call RegisterClassExA





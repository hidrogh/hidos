org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
	jmp main

; Prints a string to the screen
; Params:
; -ds:si points to string
puts:
	push si
	push ax

.loop:
	lodsb
	or al, al
	jz .done

	mov ah, 0x0e
	mov bh, 0
	int 0x10
	jmp .loop

.done:
	pop ax
	pop si
	ret

clear_screen:
	pusha
	mov ax, 0x0700
	mov bh, 0x07
	mov cx, 0x0000
	mov dx, 0x184f
	int 0x10
	popa
	ret

;main
main:
	call clear_screen
	mov ax, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00
	mov si, msg_welcome1
	call puts
	mov si, msg_welcome2
	call puts
	mov si, msg_welcome3
	call puts
	mov si, msg_welcome4
	call puts
	mov si, msg_welcome5
	call puts
	mov si, msg_welcome6
	call puts
	
	hlt
	
.halt:
	jmp .halt

msg_welcome1: db '    _    _ _     _  ____   _____ ', ENDL, 0
msg_welcome2: db '   | |  | (_)   | |/ __ \ / ____|', ENDL, 0
msg_welcome3: db '   | |__| |_  __| | |  | | (___  ', ENDL, 0
msg_welcome4: db '   |  __  | |/ _` | |  | |\___ \ ', ENDL, 0
msg_welcome5: db '   | |  | | | (_| | |__| |____) |', ENDL, 0
msg_welcome6: db '   |_|  |_|_|\__,_|\____/|_____/ ', ENDL, 0

times 510-($-$$) db 0
dw 0aa55h

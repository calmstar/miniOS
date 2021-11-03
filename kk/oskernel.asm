;//操作系统内核文件的入口
BITS 16

[extern startUp]
[extern shell]

global _start
_start:
	call dword startUp
	
KeyBoard:
		mov ah,0
		int 16h
		cmp al,0dh
		jne KeyBoard
		call dword shell
		jmp KeyBoard
	
	
